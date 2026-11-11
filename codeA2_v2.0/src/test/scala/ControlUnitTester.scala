import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class ControlUnitTester extends AnyFlatSpec with ChiselScalatestTester {

  // Expected outputs for one opcode
  case class Exp(name: String, op: UInt, alu: UInt,
                 imm: Boolean = false, regWrite: Boolean = false,
                 readData: Boolean = false, writeData: Boolean = false,
                 branch: Boolean = false, jump: Boolean = false,
                 end: Boolean = false)

  val table = Seq(
    Exp("ADD",  Opcodes.ADD,  ALUOps.ADD, regWrite = true),
    Exp("SUB",  Opcodes.SUB,  ALUOps.SUB, regWrite = true),
    Exp("MULT", Opcodes.MULT, ALUOps.MUL, regWrite = true),
    Exp("ADDI", Opcodes.ADDI, ALUOps.ADD, imm = true, regWrite = true),
    Exp("SUBI", Opcodes.SUBI, ALUOps.SUB, imm = true, regWrite = true),
    Exp("MULI", Opcodes.MULI, ALUOps.MUL, imm = true, regWrite = true),
    Exp("LI",   Opcodes.LI,   ALUOps.PASS2, imm = true, regWrite = true),
    Exp("LD",   Opcodes.LD,   ALUOps.ADD, regWrite = true, readData = true),
    Exp("SD",   Opcodes.SD,   ALUOps.ADD, imm = true, writeData = true),
    Exp("JR",   Opcodes.JR,   ALUOps.ADD, jump = true),
    Exp("JEQ",  Opcodes.JEQ,  ALUOps.EQ,  branch = true),
    Exp("JLT",  Opcodes.JLT,  ALUOps.LT,  branch = true),
    Exp("JGT",  Opcodes.JGT,  ALUOps.GT,  branch = true),
    Exp("NOP",  Opcodes.NOP,  ALUOps.ADD),
    Exp("END",  Opcodes.END,  ALUOps.ADD, end = true),
    Exp("unknown opcode", "b111111".U(6.W), ALUOps.ADD)   // must behave like a NOP
  )

  "ControlUnit" should "decode every opcode correctly" in {
    test(new ControlUnit) { dut =>
      dut.io.run.poke(true.B)
      for (e <- table) {
        dut.io.opcode.poke(e.op)
        withClue(s"opcode ${e.name}: ") {
          dut.io.aluOperation.expect(e.alu)
          dut.io.immediate.expect(e.imm.B)
          dut.io.regWrite.expect(e.regWrite.B)
          dut.io.readData.expect(e.readData.B)
          dut.io.writeData.expect(e.writeData.B)
          dut.io.branch.expect(e.branch.B)
          dut.io.jump.expect(e.jump.B)
          dut.io.stop.expect(e.end.B)
          dut.io.done.expect(e.end.B)
        }
      }
    }
  }

  it should "forward run to start" in {
    test(new ControlUnit) { dut =>
      dut.io.opcode.poke(Opcodes.ADD)
      dut.io.run.poke(false.B)
      dut.io.start.expect(false.B)
      dut.io.run.poke(true.B)
      dut.io.start.expect(true.B)
    }
  }
}