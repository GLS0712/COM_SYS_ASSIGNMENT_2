import chisel3._
import chisel3.util._

// Task 7: 32 registers x 32 bits (5-bit register fields),
// three combinational read ports (Regin/Regout 1-3) and one synchronous
// write port. A write becomes visible on the next clock cycle.
class RegisterFile extends Module {
  val io = IO(new Bundle {
    val regin1      = Input(UInt(5.W))
    val regin2      = Input(UInt(5.W))
    val regin3      = Input(UInt(5.W))
    val regout1     = Output(UInt(32.W))
    val regout2     = Output(UInt(32.W))
    val regout3     = Output(UInt(32.W))

    val writeSel    = Input(UInt(5.W))
    val writeData   = Input(UInt(32.W))
    val regWrite    = Input(Bool())
  })

  val registers = RegInit(VecInit(Seq.fill(32)(0.U(32.W))))

  io.regout1 := registers(io.regin1)
  io.regout2 := registers(io.regin2)
  io.regout3 := registers(io.regin3)

  when(io.regWrite) {
    registers(io.writeSel) := io.writeData
  }
}
