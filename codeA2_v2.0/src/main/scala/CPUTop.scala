import chisel3._
import chisel3.util._

class CPUTop extends Module {
  val io = IO(new Bundle {
    val done = Output(Bool ())
    val run = Input(Bool ())
    //This signals are used by the tester for loading and dumping the memory content, do not touch
    val testerDataMemEnable = Input(Bool ())
    val testerDataMemAddress = Input(UInt (16.W))
    val testerDataMemDataRead = Output(UInt (32.W))
    val testerDataMemWriteEnable = Input(Bool ())
    val testerDataMemDataWrite = Input(UInt (32.W))
    //This signals are used by the tester for loading and dumping the memory content, do not touch
    val testerProgMemEnable = Input(Bool ())
    val testerProgMemAddress = Input(UInt (16.W))
    val testerProgMemDataRead = Output(UInt (32.W))
    val testerProgMemWriteEnable = Input(Bool ())
    val testerProgMemDataWrite = Input(UInt (32.W))
  })

  //Creating components
  val programCounter = Module(new ProgramCounter())
  val dataMemory = Module(new DataMemory())
  val programMemory = Module(new ProgramMemory())
  val registerFile = Module(new RegisterFile())
  val controlUnit = Module(new ControlUnit())
  val alu = Module(new ALU())

  //Connecting the modules
  // programCounter.io.run := io.run
  programMemory.io.address := programCounter.io.programCounter

  ////////////////////////////////////////////
  //Continue here with your connections
  ////////////////////////////////////////////


  //This signals are used by the tester for loading the program to the program memory, do not touch
  programMemory.io.testerAddress := io.testerProgMemAddress
  io.testerProgMemDataRead := programMemory.io.testerDataRead
  programMemory.io.testerDataWrite := io.testerProgMemDataWrite
  programMemory.io.testerEnable := io.testerProgMemEnable
  programMemory.io.testerWriteEnable := io.testerProgMemWriteEnable
  //This signals are used by the tester for loading and dumping the data memory content, do not touch
  dataMemory.io.testerAddress := io.testerDataMemAddress
  io.testerDataMemDataRead := dataMemory.io.testerDataRead
  dataMemory.io.testerDataWrite := io.testerDataMemDataWrite
  dataMemory.io.testerEnable := io.testerDataMemEnable
  dataMemory.io.testerWriteEnable := io.testerDataMemWriteEnable

  // Instruction
  val instruction = programMemory.io.instructionRead

  // Control unit
  controlUnit.io.opcode := instruction(31, 26)
  controlUnit.io.run := io.run

  // Register-file read ports
  registerFile.io.regin1 := instruction(25, 21) // Rs
  registerFile.io.regin2 := instruction(20, 16) // Rt
  registerFile.io.regin3 := Mux(
    controlUnit.io.branch,
    instruction(25, 21), // Rs for comparisons
    instruction(15, 11)  // Rd for arithmetic
  )

  // Sign-extend immediate
  val immediate = Cat(Fill(16, instruction(15)), instruction(15, 0))

  // ALU
  alu.io.sel := controlUnit.io.aluOperation
  alu.io.in1 := registerFile.io.regout2
  alu.io.in2 := Mux(
    controlUnit.io.immediate,
    immediate,
    registerFile.io.regout3
  )

  // Data memory
  dataMemory.io.address := alu.io.regout1(15, 0)
  dataMemory.io.dataWrite := registerFile.io.regout2
  dataMemory.io.writeEnable := controlUnit.io.writeData

  // Register write-back
  registerFile.io.writeSel := Mux(
    controlUnit.io.readData,
    instruction(20, 16), // LD destination: Rt
    instruction(25, 21)  // ALU destination: Rs
  )
  registerFile.io.writeData := Mux(
    controlUnit.io.readData,
    dataMemory.io.dataRead,
    alu.io.result
  )
  registerFile.io.regWrite := controlUnit.io.regWrite

  // Program counter
  programCounter.io.run := controlUnit.io.start
  programCounter.io.stop := controlUnit.io.stop
  programCounter.io.jump :=
    controlUnit.io.jump ||
    (controlUnit.io.branch && alu.io.cmp)
  programCounter.io.programCounterJump := instruction(15, 0)

  // Completion signal
  io.done := controlUnit.io.done
}