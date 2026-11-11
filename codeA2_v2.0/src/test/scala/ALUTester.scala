import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class ALUTester extends AnyFlatSpec with ChiselScalatestTester {

  // Applies one operation and checks result and cmp (ALU is combinational, no clock step needed)
  def check(dut: ALU, sel: UInt, a: BigInt, b: BigInt, result: BigInt, cmp: Boolean): Unit = {
    dut.io.sel.poke(sel)
    dut.io.in1.poke(a.U(32.W))
    dut.io.in2.poke(b.U(32.W))
    dut.io.result.expect(result.U(32.W))
    dut.io.cmp.expect(cmp.B)
  }

  val minusOne = BigInt("FFFFFFFF", 16)

  "ALU" should "add, subtract and multiply" in {
    test(new ALU) { dut =>
      check(dut, ALUOps.ADD, 5, 7, 12, false)
      check(dut, ALUOps.SUB, 10, 3, 7, false)
      check(dut, ALUOps.MUL, 6, 7, 42, false)
    }
  }

  it should "wrap around on 32 bits" in {
    test(new ALU) { dut =>
      check(dut, ALUOps.SUB, 0, 1, minusOne, false)                // 0 - 1 = -1
      check(dut, ALUOps.ADD, minusOne, 1, 0, false)                // overflow wraps to 0
      check(dut, ALUOps.MUL, BigInt("80000000", 16), 2, 0, false)  // MUL truncated to 32 bits
    }
  }

  it should "pass the second operand for PASS2 (used by LI)" in {
    test(new ALU) { dut =>
      check(dut, ALUOps.PASS2, 123, 456, 456, false)
    }
  }

  it should "compare for equality (EQ)" in {
    test(new ALU) { dut =>
      check(dut, ALUOps.EQ, 9, 9, 0, true)
      check(dut, ALUOps.EQ, 9, 8, 0, false)
    }
  }

  it should "compare signed values (LT, GT)" in {
    test(new ALU) { dut =>
      check(dut, ALUOps.LT, 3, 5, 0, true)
      check(dut, ALUOps.LT, 5, 3, 0, false)
      check(dut, ALUOps.LT, 4, 4, 0, false)
      check(dut, ALUOps.LT, minusOne, 1, 0, true)   // -1 < 1 (would be false if unsigned)
      check(dut, ALUOps.GT, 5, 3, 0, true)
      check(dut, ALUOps.GT, 3, 5, 0, false)
      check(dut, ALUOps.GT, 4, 4, 0, false)
      check(dut, ALUOps.GT, 1, minusOne, 0, true)   // 1 > -1
    }
  }

  it should "keep cmp low for arithmetic operations" in {
    test(new ALU) { dut =>
      for (op <- Seq(ALUOps.ADD, ALUOps.SUB, ALUOps.MUL, ALUOps.PASS2)) {
        dut.io.sel.poke(op)
        dut.io.in1.poke(5.U)
        dut.io.in2.poke(5.U)
        dut.io.cmp.expect(false.B)
      }
    }
  }
}