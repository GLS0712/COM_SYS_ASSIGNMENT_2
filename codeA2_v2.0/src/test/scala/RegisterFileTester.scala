import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class RegisterFileTester extends AnyFlatSpec with ChiselScalatestTester {

  def write(dut: RegisterFile, reg: Int, value: BigInt): Unit = {
    dut.io.writeSel.poke(reg.U)
    dut.io.writeData.poke(value.U(32.W))
    dut.io.regWrite.poke(true.B)
    dut.clock.step(1)
    dut.io.regWrite.poke(false.B)
  }

  "RegisterFile" should "be zero after reset" in {
    test(new RegisterFile) { dut =>
      for (r <- 0 until 32) {
        dut.io.regin1.poke(r.U)
        dut.io.regout1.expect(0.U)
      }
    }
  }

  it should "return written data on the next cycle" in {
    test(new RegisterFile) { dut =>
      dut.io.regin1.poke(5.U)
      dut.io.writeSel.poke(5.U)
      dut.io.writeData.poke(1234.U)
      dut.io.regWrite.poke(true.B)
      dut.io.regout1.expect(0.U)      // old value: write is not visible yet
      dut.clock.step(1)
      dut.io.regout1.expect(1234.U)   // visible after the clock edge
    }
  }

  it should "not write when regWrite is low" in {
    test(new RegisterFile) { dut =>
      dut.io.writeSel.poke(7.U)
      dut.io.writeData.poke(99.U)
      dut.io.regWrite.poke(false.B)
      dut.clock.step(1)
      dut.io.regin1.poke(7.U)
      dut.io.regout1.expect(0.U)
    }
  }

  it should "serve three read ports at the same time" in {
    test(new RegisterFile) { dut =>
      write(dut, 1, 11)
      write(dut, 2, 22)
      write(dut, 3, 33)
      dut.io.regin1.poke(1.U)
      dut.io.regin2.poke(2.U)
      dut.io.regin3.poke(3.U)
      dut.io.regout1.expect(11.U)
      dut.io.regout2.expect(22.U)
      dut.io.regout3.expect(33.U)
    }
  }

  it should "only change the selected register" in {
    test(new RegisterFile) { dut =>
      write(dut, 10, 0xABCD)
      for (r <- 0 until 32) {
        dut.io.regin1.poke(r.U)
        dut.io.regout1.expect((if (r == 10) 0xABCD else 0).U)
      }
    }
  }

  it should "keep 32-bit values and allow overwriting" in {
    test(new RegisterFile) { dut =>
      write(dut, 31, BigInt("FFFFFFFF", 16))
      dut.io.regin2.poke(31.U)
      dut.io.regout2.expect(BigInt("FFFFFFFF", 16).U(32.W))
      write(dut, 31, 1)
      dut.io.regout2.expect(1.U)
    }
  }
}