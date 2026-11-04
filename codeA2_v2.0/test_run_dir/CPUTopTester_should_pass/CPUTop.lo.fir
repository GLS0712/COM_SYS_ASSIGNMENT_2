FIRRTL version 1.2.0
circuit CPUTop :
  module ProgramCounter :
    input clock : Clock
    input reset : UInt<1>
    input io_stop : UInt<1> @[\\src\\main\\scala\\ProgramCounter.scala 5:14]
    input io_jump : UInt<1> @[\\src\\main\\scala\\ProgramCounter.scala 5:14]
    input io_run : UInt<1> @[\\src\\main\\scala\\ProgramCounter.scala 5:14]
    input io_programCounterJump : UInt<16> @[\\src\\main\\scala\\ProgramCounter.scala 5:14]
    output io_programCounter : UInt<16> @[\\src\\main\\scala\\ProgramCounter.scala 5:14]

    reg ProgramNext : UInt<32>, clock with :
      reset => (UInt<1>("h0"), ProgramNext) @[\\src\\main\\scala\\ProgramCounter.scala 14:28]
    node _T = eq(io_run, UInt<1>("h1")) @[\\src\\main\\scala\\ProgramCounter.scala 15:17]
    node _T_1 = eq(io_jump, UInt<1>("h1")) @[\\src\\main\\scala\\ProgramCounter.scala 15:35]
    node _T_2 = and(_T, _T_1) @[\\src\\main\\scala\\ProgramCounter.scala 15:25]
    node _T_3 = eq(io_run, UInt<1>("h1")) @[\\src\\main\\scala\\ProgramCounter.scala 17:24]
    node _ProgramNext_T = add(io_programCounter, UInt<1>("h1")) @[\\src\\main\\scala\\ProgramCounter.scala 18:40]
    node _ProgramNext_T_1 = tail(_ProgramNext_T, 1) @[\\src\\main\\scala\\ProgramCounter.scala 18:40]
    node _GEN_0 = mux(_T_3, _ProgramNext_T_1, io_programCounter) @[\\src\\main\\scala\\ProgramCounter.scala 17:32 18:19 20:19]
    node _GEN_1 = mux(_T_2, io_programCounterJump, _GEN_0) @[\\src\\main\\scala\\ProgramCounter.scala 15:43 16:19]
    io_programCounter <= bits(ProgramNext, 15, 0) @[\\src\\main\\scala\\ProgramCounter.scala 23:23]
    ProgramNext <= mux(reset, UInt<32>("h0"), _GEN_1) @[\\src\\main\\scala\\ProgramCounter.scala 14:{28,28}]

  module DataMemory :
    input clock : Clock
    input reset : UInt<1>
    input io_address : UInt<16> @[\\src\\main\\scala\\DataMemory.scala 4:14]
    output io_dataRead : UInt<32> @[\\src\\main\\scala\\DataMemory.scala 4:14]
    input io_writeEnable : UInt<1> @[\\src\\main\\scala\\DataMemory.scala 4:14]
    input io_dataWrite : UInt<32> @[\\src\\main\\scala\\DataMemory.scala 4:14]
    input io_testerEnable : UInt<1> @[\\src\\main\\scala\\DataMemory.scala 4:14]
    input io_testerAddress : UInt<16> @[\\src\\main\\scala\\DataMemory.scala 4:14]
    output io_testerDataRead : UInt<32> @[\\src\\main\\scala\\DataMemory.scala 4:14]
    input io_testerWriteEnable : UInt<1> @[\\src\\main\\scala\\DataMemory.scala 4:14]
    input io_testerDataWrite : UInt<32> @[\\src\\main\\scala\\DataMemory.scala 4:14]

    mem memory : @[\\src\\main\\scala\\DataMemory.scala 18:20]
      data-type => UInt<32>
      depth => 65536
      read-latency => 0
      write-latency => 1
      reader => io_testerDataRead_MPORT
      reader => io_dataRead_MPORT
      writer => MPORT
      writer => MPORT_1
      read-under-write => undefined
    node _GEN_0 = validif(io_testerWriteEnable, io_testerAddress) @[\\src\\main\\scala\\DataMemory.scala 24:32]
    node _GEN_1 = validif(io_testerWriteEnable, clock) @[\\src\\main\\scala\\DataMemory.scala 24:32]
    node _GEN_2 = mux(io_testerWriteEnable, UInt<1>("h1"), UInt<1>("h0")) @[\\src\\main\\scala\\DataMemory.scala 18:20 24:32]
    node _GEN_3 = validif(io_testerWriteEnable, UInt<1>("h1")) @[\\src\\main\\scala\\DataMemory.scala 24:32]
    node _GEN_4 = validif(io_testerWriteEnable, io_testerDataWrite) @[\\src\\main\\scala\\DataMemory.scala 24:32]
    node _GEN_5 = mux(io_testerWriteEnable, io_testerDataWrite, memory.io_testerDataRead_MPORT.data) @[\\src\\main\\scala\\DataMemory.scala 22:23 24:32 26:25]
    node _GEN_6 = validif(io_writeEnable, io_address) @[\\src\\main\\scala\\DataMemory.scala 32:26]
    node _GEN_7 = validif(io_writeEnable, clock) @[\\src\\main\\scala\\DataMemory.scala 32:26]
    node _GEN_8 = mux(io_writeEnable, UInt<1>("h1"), UInt<1>("h0")) @[\\src\\main\\scala\\DataMemory.scala 18:20 32:26]
    node _GEN_9 = validif(io_writeEnable, UInt<1>("h1")) @[\\src\\main\\scala\\DataMemory.scala 32:26]
    node _GEN_10 = validif(io_writeEnable, io_dataWrite) @[\\src\\main\\scala\\DataMemory.scala 32:26]
    node _GEN_11 = mux(io_writeEnable, io_dataWrite, memory.io_dataRead_MPORT.data) @[\\src\\main\\scala\\DataMemory.scala 30:17 32:26 34:19]
    node _GEN_12 = validif(io_testerEnable, io_testerAddress) @[\\src\\main\\scala\\DataMemory.scala 20:24 22:37]
    node _GEN_13 = validif(io_testerEnable, clock) @[\\src\\main\\scala\\DataMemory.scala 20:24 22:37]
    node _GEN_14 = mux(io_testerEnable, UInt<1>("h1"), UInt<1>("h0")) @[\\src\\main\\scala\\DataMemory.scala 18:20 20:24 22:37]
    node _GEN_15 = mux(io_testerEnable, _GEN_5, UInt<32>("h0")) @[\\src\\main\\scala\\DataMemory.scala 20:24 31:23]
    node _GEN_16 = mux(io_testerEnable, UInt<32>("h0"), _GEN_11) @[\\src\\main\\scala\\DataMemory.scala 20:24 23:17]
    node _GEN_17 = validif(io_testerEnable, _GEN_0) @[\\src\\main\\scala\\DataMemory.scala 20:24]
    node _GEN_18 = validif(io_testerEnable, _GEN_1) @[\\src\\main\\scala\\DataMemory.scala 20:24]
    node _GEN_19 = mux(io_testerEnable, _GEN_2, UInt<1>("h0")) @[\\src\\main\\scala\\DataMemory.scala 18:20 20:24]
    node _GEN_20 = validif(io_testerEnable, _GEN_3) @[\\src\\main\\scala\\DataMemory.scala 20:24]
    node _GEN_21 = validif(io_testerEnable, _GEN_4) @[\\src\\main\\scala\\DataMemory.scala 20:24]
    node _GEN_22 = validif(eq(io_testerEnable, UInt<1>("h0")), io_address) @[\\src\\main\\scala\\DataMemory.scala 20:24 30:31]
    node _GEN_23 = validif(eq(io_testerEnable, UInt<1>("h0")), clock) @[\\src\\main\\scala\\DataMemory.scala 20:24 30:31]
    node _GEN_24 = mux(io_testerEnable, UInt<1>("h0"), UInt<1>("h1")) @[\\src\\main\\scala\\DataMemory.scala 18:20 20:24 30:31]
    node _GEN_25 = validif(eq(io_testerEnable, UInt<1>("h0")), _GEN_6) @[\\src\\main\\scala\\DataMemory.scala 20:24]
    node _GEN_26 = validif(eq(io_testerEnable, UInt<1>("h0")), _GEN_7) @[\\src\\main\\scala\\DataMemory.scala 20:24]
    node _GEN_27 = mux(io_testerEnable, UInt<1>("h0"), _GEN_8) @[\\src\\main\\scala\\DataMemory.scala 18:20 20:24]
    node _GEN_28 = validif(eq(io_testerEnable, UInt<1>("h0")), _GEN_9) @[\\src\\main\\scala\\DataMemory.scala 20:24]
    node _GEN_29 = validif(eq(io_testerEnable, UInt<1>("h0")), _GEN_10) @[\\src\\main\\scala\\DataMemory.scala 20:24]
    io_dataRead <= _GEN_16
    io_testerDataRead <= _GEN_15
    memory.io_testerDataRead_MPORT.addr <= _GEN_12
    memory.io_testerDataRead_MPORT.en <= _GEN_14
    memory.io_testerDataRead_MPORT.clk <= _GEN_13
    memory.io_dataRead_MPORT.addr <= _GEN_22
    memory.io_dataRead_MPORT.en <= _GEN_24
    memory.io_dataRead_MPORT.clk <= _GEN_23
    memory.MPORT.addr <= _GEN_17
    memory.MPORT.en <= _GEN_19
    memory.MPORT.clk <= _GEN_18
    memory.MPORT.data <= _GEN_21
    memory.MPORT.mask <= _GEN_20
    memory.MPORT_1.addr <= _GEN_25
    memory.MPORT_1.en <= _GEN_27
    memory.MPORT_1.clk <= _GEN_26
    memory.MPORT_1.data <= _GEN_29
    memory.MPORT_1.mask <= _GEN_28

  module ProgramMemory :
    input clock : Clock
    input reset : UInt<1>
    input io_address : UInt<16> @[\\src\\main\\scala\\ProgramMemory.scala 4:14]
    output io_instructionRead : UInt<32> @[\\src\\main\\scala\\ProgramMemory.scala 4:14]
    input io_testerEnable : UInt<1> @[\\src\\main\\scala\\ProgramMemory.scala 4:14]
    input io_testerAddress : UInt<16> @[\\src\\main\\scala\\ProgramMemory.scala 4:14]
    output io_testerDataRead : UInt<32> @[\\src\\main\\scala\\ProgramMemory.scala 4:14]
    input io_testerWriteEnable : UInt<1> @[\\src\\main\\scala\\ProgramMemory.scala 4:14]
    input io_testerDataWrite : UInt<32> @[\\src\\main\\scala\\ProgramMemory.scala 4:14]

    mem memory : @[\\src\\main\\scala\\ProgramMemory.scala 16:20]
      data-type => UInt<32>
      depth => 65536
      read-latency => 0
      write-latency => 1
      reader => io_testerDataRead_MPORT
      reader => io_instructionRead_MPORT
      writer => MPORT
      read-under-write => undefined
    node _GEN_0 = validif(io_testerWriteEnable, io_testerAddress) @[\\src\\main\\scala\\ProgramMemory.scala 22:32]
    node _GEN_1 = validif(io_testerWriteEnable, clock) @[\\src\\main\\scala\\ProgramMemory.scala 22:32]
    node _GEN_2 = mux(io_testerWriteEnable, UInt<1>("h1"), UInt<1>("h0")) @[\\src\\main\\scala\\ProgramMemory.scala 16:20 22:32]
    node _GEN_3 = validif(io_testerWriteEnable, UInt<1>("h1")) @[\\src\\main\\scala\\ProgramMemory.scala 22:32]
    node _GEN_4 = validif(io_testerWriteEnable, io_testerDataWrite) @[\\src\\main\\scala\\ProgramMemory.scala 22:32]
    node _GEN_5 = mux(io_testerWriteEnable, io_testerDataWrite, memory.io_testerDataRead_MPORT.data) @[\\src\\main\\scala\\ProgramMemory.scala 20:23 22:32 24:25]
    node _GEN_6 = validif(io_testerEnable, io_testerAddress) @[\\src\\main\\scala\\ProgramMemory.scala 18:24 20:37]
    node _GEN_7 = validif(io_testerEnable, clock) @[\\src\\main\\scala\\ProgramMemory.scala 18:24 20:37]
    node _GEN_8 = mux(io_testerEnable, UInt<1>("h1"), UInt<1>("h0")) @[\\src\\main\\scala\\ProgramMemory.scala 16:20 18:24 20:37]
    node _GEN_9 = mux(io_testerEnable, _GEN_5, UInt<32>("h0")) @[\\src\\main\\scala\\ProgramMemory.scala 18:24 29:23]
    node _GEN_10 = mux(io_testerEnable, UInt<32>("h0"), memory.io_instructionRead_MPORT.data) @[\\src\\main\\scala\\ProgramMemory.scala 18:24 21:24 28:24]
    node _GEN_11 = validif(io_testerEnable, _GEN_0) @[\\src\\main\\scala\\ProgramMemory.scala 18:24]
    node _GEN_12 = validif(io_testerEnable, _GEN_1) @[\\src\\main\\scala\\ProgramMemory.scala 18:24]
    node _GEN_13 = mux(io_testerEnable, _GEN_2, UInt<1>("h0")) @[\\src\\main\\scala\\ProgramMemory.scala 16:20 18:24]
    node _GEN_14 = validif(io_testerEnable, _GEN_3) @[\\src\\main\\scala\\ProgramMemory.scala 18:24]
    node _GEN_15 = validif(io_testerEnable, _GEN_4) @[\\src\\main\\scala\\ProgramMemory.scala 18:24]
    node _GEN_16 = validif(eq(io_testerEnable, UInt<1>("h0")), io_address) @[\\src\\main\\scala\\ProgramMemory.scala 18:24 28:38]
    node _GEN_17 = validif(eq(io_testerEnable, UInt<1>("h0")), clock) @[\\src\\main\\scala\\ProgramMemory.scala 18:24 28:38]
    node _GEN_18 = mux(io_testerEnable, UInt<1>("h0"), UInt<1>("h1")) @[\\src\\main\\scala\\ProgramMemory.scala 16:20 18:24 28:38]
    io_instructionRead <= _GEN_10
    io_testerDataRead <= _GEN_9
    memory.io_testerDataRead_MPORT.addr <= _GEN_6
    memory.io_testerDataRead_MPORT.en <= _GEN_8
    memory.io_testerDataRead_MPORT.clk <= _GEN_7
    memory.io_instructionRead_MPORT.addr <= _GEN_16
    memory.io_instructionRead_MPORT.en <= _GEN_18
    memory.io_instructionRead_MPORT.clk <= _GEN_17
    memory.MPORT.addr <= _GEN_11
    memory.MPORT.en <= _GEN_13
    memory.MPORT.clk <= _GEN_12
    memory.MPORT.data <= _GEN_15
    memory.MPORT.mask <= _GEN_14

  module RegisterFile :
    input clock : Clock
    input reset : UInt<1>
    input io_regin1 : UInt<5> @[\\src\\main\\scala\\RegisterFile.scala 8:14]
    input io_regin2 : UInt<5> @[\\src\\main\\scala\\RegisterFile.scala 8:14]
    input io_regin3 : UInt<5> @[\\src\\main\\scala\\RegisterFile.scala 8:14]
    output io_regout1 : UInt<32> @[\\src\\main\\scala\\RegisterFile.scala 8:14]
    output io_regout2 : UInt<32> @[\\src\\main\\scala\\RegisterFile.scala 8:14]
    output io_regout3 : UInt<32> @[\\src\\main\\scala\\RegisterFile.scala 8:14]
    input io_writeSel : UInt<5> @[\\src\\main\\scala\\RegisterFile.scala 8:14]
    input io_writeData : UInt<32> @[\\src\\main\\scala\\RegisterFile.scala 8:14]
    input io_regWrite : UInt<1> @[\\src\\main\\scala\\RegisterFile.scala 8:14]

    reg registers_0 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_0) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    reg registers_1 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_1) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    reg registers_2 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_2) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    reg registers_3 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_3) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    reg registers_4 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_4) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    reg registers_5 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_5) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    reg registers_6 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_6) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    reg registers_7 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_7) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    reg registers_8 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_8) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    reg registers_9 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_9) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    reg registers_10 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_10) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    reg registers_11 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_11) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    reg registers_12 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_12) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    reg registers_13 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_13) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    reg registers_14 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_14) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    reg registers_15 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_15) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    reg registers_16 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_16) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    reg registers_17 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_17) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    reg registers_18 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_18) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    reg registers_19 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_19) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    reg registers_20 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_20) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    reg registers_21 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_21) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    reg registers_22 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_22) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    reg registers_23 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_23) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    reg registers_24 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_24) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    reg registers_25 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_25) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    reg registers_26 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_26) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    reg registers_27 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_27) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    reg registers_28 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_28) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    reg registers_29 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_29) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    reg registers_30 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_30) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    reg registers_31 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), registers_31) @[\\src\\main\\scala\\RegisterFile.scala 21:26]
    node _GEN_0 = validif(eq(UInt<1>("h0"), io_regin1), registers_0) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_1 = mux(eq(UInt<1>("h1"), io_regin1), registers_1, _GEN_0) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_2 = mux(eq(UInt<2>("h2"), io_regin1), registers_2, _GEN_1) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_3 = mux(eq(UInt<2>("h3"), io_regin1), registers_3, _GEN_2) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_4 = mux(eq(UInt<3>("h4"), io_regin1), registers_4, _GEN_3) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_5 = mux(eq(UInt<3>("h5"), io_regin1), registers_5, _GEN_4) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_6 = mux(eq(UInt<3>("h6"), io_regin1), registers_6, _GEN_5) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_7 = mux(eq(UInt<3>("h7"), io_regin1), registers_7, _GEN_6) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_8 = mux(eq(UInt<4>("h8"), io_regin1), registers_8, _GEN_7) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_9 = mux(eq(UInt<4>("h9"), io_regin1), registers_9, _GEN_8) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_10 = mux(eq(UInt<4>("ha"), io_regin1), registers_10, _GEN_9) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_11 = mux(eq(UInt<4>("hb"), io_regin1), registers_11, _GEN_10) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_12 = mux(eq(UInt<4>("hc"), io_regin1), registers_12, _GEN_11) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_13 = mux(eq(UInt<4>("hd"), io_regin1), registers_13, _GEN_12) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_14 = mux(eq(UInt<4>("he"), io_regin1), registers_14, _GEN_13) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_15 = mux(eq(UInt<4>("hf"), io_regin1), registers_15, _GEN_14) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_16 = mux(eq(UInt<5>("h10"), io_regin1), registers_16, _GEN_15) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_17 = mux(eq(UInt<5>("h11"), io_regin1), registers_17, _GEN_16) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_18 = mux(eq(UInt<5>("h12"), io_regin1), registers_18, _GEN_17) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_19 = mux(eq(UInt<5>("h13"), io_regin1), registers_19, _GEN_18) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_20 = mux(eq(UInt<5>("h14"), io_regin1), registers_20, _GEN_19) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_21 = mux(eq(UInt<5>("h15"), io_regin1), registers_21, _GEN_20) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_22 = mux(eq(UInt<5>("h16"), io_regin1), registers_22, _GEN_21) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_23 = mux(eq(UInt<5>("h17"), io_regin1), registers_23, _GEN_22) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_24 = mux(eq(UInt<5>("h18"), io_regin1), registers_24, _GEN_23) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_25 = mux(eq(UInt<5>("h19"), io_regin1), registers_25, _GEN_24) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_26 = mux(eq(UInt<5>("h1a"), io_regin1), registers_26, _GEN_25) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_27 = mux(eq(UInt<5>("h1b"), io_regin1), registers_27, _GEN_26) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_28 = mux(eq(UInt<5>("h1c"), io_regin1), registers_28, _GEN_27) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_29 = mux(eq(UInt<5>("h1d"), io_regin1), registers_29, _GEN_28) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_30 = mux(eq(UInt<5>("h1e"), io_regin1), registers_30, _GEN_29) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_31 = mux(eq(UInt<5>("h1f"), io_regin1), registers_31, _GEN_30) @[\\src\\main\\scala\\RegisterFile.scala 23:{14,14}]
    node _GEN_32 = validif(eq(UInt<1>("h0"), io_regin2), registers_0) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_33 = mux(eq(UInt<1>("h1"), io_regin2), registers_1, _GEN_32) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_34 = mux(eq(UInt<2>("h2"), io_regin2), registers_2, _GEN_33) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_35 = mux(eq(UInt<2>("h3"), io_regin2), registers_3, _GEN_34) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_36 = mux(eq(UInt<3>("h4"), io_regin2), registers_4, _GEN_35) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_37 = mux(eq(UInt<3>("h5"), io_regin2), registers_5, _GEN_36) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_38 = mux(eq(UInt<3>("h6"), io_regin2), registers_6, _GEN_37) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_39 = mux(eq(UInt<3>("h7"), io_regin2), registers_7, _GEN_38) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_40 = mux(eq(UInt<4>("h8"), io_regin2), registers_8, _GEN_39) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_41 = mux(eq(UInt<4>("h9"), io_regin2), registers_9, _GEN_40) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_42 = mux(eq(UInt<4>("ha"), io_regin2), registers_10, _GEN_41) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_43 = mux(eq(UInt<4>("hb"), io_regin2), registers_11, _GEN_42) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_44 = mux(eq(UInt<4>("hc"), io_regin2), registers_12, _GEN_43) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_45 = mux(eq(UInt<4>("hd"), io_regin2), registers_13, _GEN_44) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_46 = mux(eq(UInt<4>("he"), io_regin2), registers_14, _GEN_45) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_47 = mux(eq(UInt<4>("hf"), io_regin2), registers_15, _GEN_46) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_48 = mux(eq(UInt<5>("h10"), io_regin2), registers_16, _GEN_47) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_49 = mux(eq(UInt<5>("h11"), io_regin2), registers_17, _GEN_48) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_50 = mux(eq(UInt<5>("h12"), io_regin2), registers_18, _GEN_49) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_51 = mux(eq(UInt<5>("h13"), io_regin2), registers_19, _GEN_50) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_52 = mux(eq(UInt<5>("h14"), io_regin2), registers_20, _GEN_51) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_53 = mux(eq(UInt<5>("h15"), io_regin2), registers_21, _GEN_52) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_54 = mux(eq(UInt<5>("h16"), io_regin2), registers_22, _GEN_53) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_55 = mux(eq(UInt<5>("h17"), io_regin2), registers_23, _GEN_54) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_56 = mux(eq(UInt<5>("h18"), io_regin2), registers_24, _GEN_55) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_57 = mux(eq(UInt<5>("h19"), io_regin2), registers_25, _GEN_56) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_58 = mux(eq(UInt<5>("h1a"), io_regin2), registers_26, _GEN_57) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_59 = mux(eq(UInt<5>("h1b"), io_regin2), registers_27, _GEN_58) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_60 = mux(eq(UInt<5>("h1c"), io_regin2), registers_28, _GEN_59) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_61 = mux(eq(UInt<5>("h1d"), io_regin2), registers_29, _GEN_60) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_62 = mux(eq(UInt<5>("h1e"), io_regin2), registers_30, _GEN_61) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_63 = mux(eq(UInt<5>("h1f"), io_regin2), registers_31, _GEN_62) @[\\src\\main\\scala\\RegisterFile.scala 24:{14,14}]
    node _GEN_64 = validif(eq(UInt<1>("h0"), io_regin3), registers_0) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _GEN_65 = mux(eq(UInt<1>("h1"), io_regin3), registers_1, _GEN_64) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _GEN_66 = mux(eq(UInt<2>("h2"), io_regin3), registers_2, _GEN_65) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _GEN_67 = mux(eq(UInt<2>("h3"), io_regin3), registers_3, _GEN_66) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _GEN_68 = mux(eq(UInt<3>("h4"), io_regin3), registers_4, _GEN_67) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _GEN_69 = mux(eq(UInt<3>("h5"), io_regin3), registers_5, _GEN_68) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _GEN_70 = mux(eq(UInt<3>("h6"), io_regin3), registers_6, _GEN_69) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _GEN_71 = mux(eq(UInt<3>("h7"), io_regin3), registers_7, _GEN_70) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _GEN_72 = mux(eq(UInt<4>("h8"), io_regin3), registers_8, _GEN_71) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _GEN_73 = mux(eq(UInt<4>("h9"), io_regin3), registers_9, _GEN_72) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _GEN_74 = mux(eq(UInt<4>("ha"), io_regin3), registers_10, _GEN_73) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _GEN_75 = mux(eq(UInt<4>("hb"), io_regin3), registers_11, _GEN_74) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _GEN_76 = mux(eq(UInt<4>("hc"), io_regin3), registers_12, _GEN_75) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _GEN_77 = mux(eq(UInt<4>("hd"), io_regin3), registers_13, _GEN_76) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _GEN_78 = mux(eq(UInt<4>("he"), io_regin3), registers_14, _GEN_77) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _GEN_79 = mux(eq(UInt<4>("hf"), io_regin3), registers_15, _GEN_78) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _GEN_80 = mux(eq(UInt<5>("h10"), io_regin3), registers_16, _GEN_79) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _GEN_81 = mux(eq(UInt<5>("h11"), io_regin3), registers_17, _GEN_80) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _GEN_82 = mux(eq(UInt<5>("h12"), io_regin3), registers_18, _GEN_81) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _GEN_83 = mux(eq(UInt<5>("h13"), io_regin3), registers_19, _GEN_82) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _GEN_84 = mux(eq(UInt<5>("h14"), io_regin3), registers_20, _GEN_83) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _GEN_85 = mux(eq(UInt<5>("h15"), io_regin3), registers_21, _GEN_84) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _GEN_86 = mux(eq(UInt<5>("h16"), io_regin3), registers_22, _GEN_85) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _GEN_87 = mux(eq(UInt<5>("h17"), io_regin3), registers_23, _GEN_86) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _GEN_88 = mux(eq(UInt<5>("h18"), io_regin3), registers_24, _GEN_87) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _GEN_89 = mux(eq(UInt<5>("h19"), io_regin3), registers_25, _GEN_88) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _GEN_90 = mux(eq(UInt<5>("h1a"), io_regin3), registers_26, _GEN_89) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _GEN_91 = mux(eq(UInt<5>("h1b"), io_regin3), registers_27, _GEN_90) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _GEN_92 = mux(eq(UInt<5>("h1c"), io_regin3), registers_28, _GEN_91) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _GEN_93 = mux(eq(UInt<5>("h1d"), io_regin3), registers_29, _GEN_92) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _GEN_94 = mux(eq(UInt<5>("h1e"), io_regin3), registers_30, _GEN_93) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _GEN_95 = mux(eq(UInt<5>("h1f"), io_regin3), registers_31, _GEN_94) @[\\src\\main\\scala\\RegisterFile.scala 25:{14,14}]
    node _registers_io_writeSel = io_writeData @[\\src\\main\\scala\\RegisterFile.scala 28:{28,28}]
    node _GEN_96 = mux(eq(UInt<1>("h0"), io_writeSel), _registers_io_writeSel, registers_0) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_97 = mux(eq(UInt<1>("h1"), io_writeSel), _registers_io_writeSel, registers_1) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_98 = mux(eq(UInt<2>("h2"), io_writeSel), _registers_io_writeSel, registers_2) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_99 = mux(eq(UInt<2>("h3"), io_writeSel), _registers_io_writeSel, registers_3) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_100 = mux(eq(UInt<3>("h4"), io_writeSel), _registers_io_writeSel, registers_4) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_101 = mux(eq(UInt<3>("h5"), io_writeSel), _registers_io_writeSel, registers_5) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_102 = mux(eq(UInt<3>("h6"), io_writeSel), _registers_io_writeSel, registers_6) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_103 = mux(eq(UInt<3>("h7"), io_writeSel), _registers_io_writeSel, registers_7) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_104 = mux(eq(UInt<4>("h8"), io_writeSel), _registers_io_writeSel, registers_8) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_105 = mux(eq(UInt<4>("h9"), io_writeSel), _registers_io_writeSel, registers_9) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_106 = mux(eq(UInt<4>("ha"), io_writeSel), _registers_io_writeSel, registers_10) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_107 = mux(eq(UInt<4>("hb"), io_writeSel), _registers_io_writeSel, registers_11) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_108 = mux(eq(UInt<4>("hc"), io_writeSel), _registers_io_writeSel, registers_12) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_109 = mux(eq(UInt<4>("hd"), io_writeSel), _registers_io_writeSel, registers_13) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_110 = mux(eq(UInt<4>("he"), io_writeSel), _registers_io_writeSel, registers_14) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_111 = mux(eq(UInt<4>("hf"), io_writeSel), _registers_io_writeSel, registers_15) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_112 = mux(eq(UInt<5>("h10"), io_writeSel), _registers_io_writeSel, registers_16) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_113 = mux(eq(UInt<5>("h11"), io_writeSel), _registers_io_writeSel, registers_17) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_114 = mux(eq(UInt<5>("h12"), io_writeSel), _registers_io_writeSel, registers_18) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_115 = mux(eq(UInt<5>("h13"), io_writeSel), _registers_io_writeSel, registers_19) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_116 = mux(eq(UInt<5>("h14"), io_writeSel), _registers_io_writeSel, registers_20) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_117 = mux(eq(UInt<5>("h15"), io_writeSel), _registers_io_writeSel, registers_21) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_118 = mux(eq(UInt<5>("h16"), io_writeSel), _registers_io_writeSel, registers_22) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_119 = mux(eq(UInt<5>("h17"), io_writeSel), _registers_io_writeSel, registers_23) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_120 = mux(eq(UInt<5>("h18"), io_writeSel), _registers_io_writeSel, registers_24) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_121 = mux(eq(UInt<5>("h19"), io_writeSel), _registers_io_writeSel, registers_25) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_122 = mux(eq(UInt<5>("h1a"), io_writeSel), _registers_io_writeSel, registers_26) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_123 = mux(eq(UInt<5>("h1b"), io_writeSel), _registers_io_writeSel, registers_27) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_124 = mux(eq(UInt<5>("h1c"), io_writeSel), _registers_io_writeSel, registers_28) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_125 = mux(eq(UInt<5>("h1d"), io_writeSel), _registers_io_writeSel, registers_29) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_126 = mux(eq(UInt<5>("h1e"), io_writeSel), _registers_io_writeSel, registers_30) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_127 = mux(eq(UInt<5>("h1f"), io_writeSel), _registers_io_writeSel, registers_31) @[\\src\\main\\scala\\RegisterFile.scala 21:26 28:{28,28}]
    node _GEN_128 = mux(io_regWrite, _GEN_96, registers_0) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _GEN_129 = mux(io_regWrite, _GEN_97, registers_1) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _GEN_130 = mux(io_regWrite, _GEN_98, registers_2) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _GEN_131 = mux(io_regWrite, _GEN_99, registers_3) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _GEN_132 = mux(io_regWrite, _GEN_100, registers_4) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _GEN_133 = mux(io_regWrite, _GEN_101, registers_5) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _GEN_134 = mux(io_regWrite, _GEN_102, registers_6) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _GEN_135 = mux(io_regWrite, _GEN_103, registers_7) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _GEN_136 = mux(io_regWrite, _GEN_104, registers_8) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _GEN_137 = mux(io_regWrite, _GEN_105, registers_9) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _GEN_138 = mux(io_regWrite, _GEN_106, registers_10) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _GEN_139 = mux(io_regWrite, _GEN_107, registers_11) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _GEN_140 = mux(io_regWrite, _GEN_108, registers_12) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _GEN_141 = mux(io_regWrite, _GEN_109, registers_13) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _GEN_142 = mux(io_regWrite, _GEN_110, registers_14) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _GEN_143 = mux(io_regWrite, _GEN_111, registers_15) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _GEN_144 = mux(io_regWrite, _GEN_112, registers_16) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _GEN_145 = mux(io_regWrite, _GEN_113, registers_17) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _GEN_146 = mux(io_regWrite, _GEN_114, registers_18) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _GEN_147 = mux(io_regWrite, _GEN_115, registers_19) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _GEN_148 = mux(io_regWrite, _GEN_116, registers_20) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _GEN_149 = mux(io_regWrite, _GEN_117, registers_21) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _GEN_150 = mux(io_regWrite, _GEN_118, registers_22) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _GEN_151 = mux(io_regWrite, _GEN_119, registers_23) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _GEN_152 = mux(io_regWrite, _GEN_120, registers_24) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _GEN_153 = mux(io_regWrite, _GEN_121, registers_25) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _GEN_154 = mux(io_regWrite, _GEN_122, registers_26) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _GEN_155 = mux(io_regWrite, _GEN_123, registers_27) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _GEN_156 = mux(io_regWrite, _GEN_124, registers_28) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _GEN_157 = mux(io_regWrite, _GEN_125, registers_29) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _GEN_158 = mux(io_regWrite, _GEN_126, registers_30) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _GEN_159 = mux(io_regWrite, _GEN_127, registers_31) @[\\src\\main\\scala\\RegisterFile.scala 27:21 21:26]
    node _registers_WIRE_0 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_WIRE_1 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_WIRE_2 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_WIRE_3 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_WIRE_4 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_WIRE_5 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_WIRE_6 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_WIRE_7 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_WIRE_8 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_WIRE_9 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_WIRE_10 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_WIRE_11 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_WIRE_12 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_WIRE_13 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_WIRE_14 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_WIRE_15 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_WIRE_16 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_WIRE_17 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_WIRE_18 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_WIRE_19 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_WIRE_20 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_WIRE_21 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_WIRE_22 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_WIRE_23 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_WIRE_24 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_WIRE_25 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_WIRE_26 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_WIRE_27 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_WIRE_28 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_WIRE_29 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_WIRE_30 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_WIRE_31 = UInt<32>("h0") @[\\src\\main\\scala\\RegisterFile.scala 21:{34,34}]
    node _registers_io_regin1 = _GEN_31 @[\\src\\main\\scala\\RegisterFile.scala 23:14]
    node _registers_io_regin2 = _GEN_63 @[\\src\\main\\scala\\RegisterFile.scala 24:14]
    node _registers_io_regin3 = _GEN_95 @[\\src\\main\\scala\\RegisterFile.scala 25:14]
    io_regout1 <= _registers_io_regin1 @[\\src\\main\\scala\\RegisterFile.scala 23:14]
    io_regout2 <= _registers_io_regin2 @[\\src\\main\\scala\\RegisterFile.scala 24:14]
    io_regout3 <= _registers_io_regin3 @[\\src\\main\\scala\\RegisterFile.scala 25:14]
    registers_0 <= mux(reset, _registers_WIRE_0, _GEN_128) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]
    registers_1 <= mux(reset, _registers_WIRE_1, _GEN_129) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]
    registers_2 <= mux(reset, _registers_WIRE_2, _GEN_130) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]
    registers_3 <= mux(reset, _registers_WIRE_3, _GEN_131) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]
    registers_4 <= mux(reset, _registers_WIRE_4, _GEN_132) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]
    registers_5 <= mux(reset, _registers_WIRE_5, _GEN_133) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]
    registers_6 <= mux(reset, _registers_WIRE_6, _GEN_134) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]
    registers_7 <= mux(reset, _registers_WIRE_7, _GEN_135) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]
    registers_8 <= mux(reset, _registers_WIRE_8, _GEN_136) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]
    registers_9 <= mux(reset, _registers_WIRE_9, _GEN_137) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]
    registers_10 <= mux(reset, _registers_WIRE_10, _GEN_138) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]
    registers_11 <= mux(reset, _registers_WIRE_11, _GEN_139) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]
    registers_12 <= mux(reset, _registers_WIRE_12, _GEN_140) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]
    registers_13 <= mux(reset, _registers_WIRE_13, _GEN_141) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]
    registers_14 <= mux(reset, _registers_WIRE_14, _GEN_142) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]
    registers_15 <= mux(reset, _registers_WIRE_15, _GEN_143) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]
    registers_16 <= mux(reset, _registers_WIRE_16, _GEN_144) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]
    registers_17 <= mux(reset, _registers_WIRE_17, _GEN_145) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]
    registers_18 <= mux(reset, _registers_WIRE_18, _GEN_146) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]
    registers_19 <= mux(reset, _registers_WIRE_19, _GEN_147) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]
    registers_20 <= mux(reset, _registers_WIRE_20, _GEN_148) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]
    registers_21 <= mux(reset, _registers_WIRE_21, _GEN_149) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]
    registers_22 <= mux(reset, _registers_WIRE_22, _GEN_150) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]
    registers_23 <= mux(reset, _registers_WIRE_23, _GEN_151) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]
    registers_24 <= mux(reset, _registers_WIRE_24, _GEN_152) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]
    registers_25 <= mux(reset, _registers_WIRE_25, _GEN_153) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]
    registers_26 <= mux(reset, _registers_WIRE_26, _GEN_154) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]
    registers_27 <= mux(reset, _registers_WIRE_27, _GEN_155) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]
    registers_28 <= mux(reset, _registers_WIRE_28, _GEN_156) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]
    registers_29 <= mux(reset, _registers_WIRE_29, _GEN_157) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]
    registers_30 <= mux(reset, _registers_WIRE_30, _GEN_158) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]
    registers_31 <= mux(reset, _registers_WIRE_31, _GEN_159) @[\\src\\main\\scala\\RegisterFile.scala 21:{26,26}]

  module ControlUnit :
    input clock : Clock
    input reset : UInt<1>
    input io_opcode : UInt<6> @[\\src\\main\\scala\\ControlUnit.scala 28:14]
    input io_run : UInt<1> @[\\src\\main\\scala\\ControlUnit.scala 28:14]
    output io_aluOperation : UInt<3> @[\\src\\main\\scala\\ControlUnit.scala 28:14]
    output io_immediate : UInt<1> @[\\src\\main\\scala\\ControlUnit.scala 28:14]
    output io_regWrite : UInt<1> @[\\src\\main\\scala\\ControlUnit.scala 28:14]
    output io_readData : UInt<1> @[\\src\\main\\scala\\ControlUnit.scala 28:14]
    output io_writeData : UInt<1> @[\\src\\main\\scala\\ControlUnit.scala 28:14]
    output io_branch : UInt<1> @[\\src\\main\\scala\\ControlUnit.scala 28:14]
    output io_jump : UInt<1> @[\\src\\main\\scala\\ControlUnit.scala 28:14]
    output io_start : UInt<1> @[\\src\\main\\scala\\ControlUnit.scala 28:14]
    output io_stop : UInt<1> @[\\src\\main\\scala\\ControlUnit.scala 28:14]
    output io_done : UInt<1> @[\\src\\main\\scala\\ControlUnit.scala 28:14]

    node isEnd = eq(io_opcode, UInt<6>("h26")) @[\\src\\main\\scala\\ControlUnit.scala 54:25]
    node _T = eq(UInt<6>("h9"), io_opcode) @[\\src\\main\\scala\\ControlUnit.scala 59:21]
    node _T_1 = eq(UInt<6>("ha"), io_opcode) @[\\src\\main\\scala\\ControlUnit.scala 59:21]
    node _T_2 = eq(UInt<6>("hb"), io_opcode) @[\\src\\main\\scala\\ControlUnit.scala 59:21]
    node _T_3 = eq(UInt<6>("hc"), io_opcode) @[\\src\\main\\scala\\ControlUnit.scala 59:21]
    node _T_4 = eq(UInt<6>("hd"), io_opcode) @[\\src\\main\\scala\\ControlUnit.scala 59:21]
    node _T_5 = eq(UInt<6>("he"), io_opcode) @[\\src\\main\\scala\\ControlUnit.scala 59:21]
    node _T_6 = eq(UInt<6>("h11"), io_opcode) @[\\src\\main\\scala\\ControlUnit.scala 59:21]
    node _T_7 = eq(UInt<6>("h12"), io_opcode) @[\\src\\main\\scala\\ControlUnit.scala 59:21]
    node _T_8 = eq(UInt<6>("h14"), io_opcode) @[\\src\\main\\scala\\ControlUnit.scala 59:21]
    node _T_9 = eq(UInt<6>("h21"), io_opcode) @[\\src\\main\\scala\\ControlUnit.scala 59:21]
    node _T_10 = eq(UInt<6>("h22"), io_opcode) @[\\src\\main\\scala\\ControlUnit.scala 59:21]
    node _T_11 = eq(UInt<6>("h23"), io_opcode) @[\\src\\main\\scala\\ControlUnit.scala 59:21]
    node _T_12 = eq(UInt<6>("h24"), io_opcode) @[\\src\\main\\scala\\ControlUnit.scala 59:21]
    node _GEN_0 = mux(_T_12, UInt<1>("h1"), UInt<1>("h0")) @[\\src\\main\\scala\\ControlUnit.scala 51:19 59:21 84:34]
    node _GEN_1 = mux(_T_12, UInt<3>("h5"), UInt<3>("h0")) @[\\src\\main\\scala\\ControlUnit.scala 46:19 59:21 84:61]
    node _GEN_2 = mux(_T_11, UInt<1>("h1"), _GEN_0) @[\\src\\main\\scala\\ControlUnit.scala 59:21 83:34]
    node _GEN_3 = mux(_T_11, UInt<3>("h6"), _GEN_1) @[\\src\\main\\scala\\ControlUnit.scala 59:21 83:61]
    node _GEN_4 = mux(_T_10, UInt<1>("h1"), _GEN_2) @[\\src\\main\\scala\\ControlUnit.scala 59:21 82:34]
    node _GEN_5 = mux(_T_10, UInt<3>("h4"), _GEN_3) @[\\src\\main\\scala\\ControlUnit.scala 59:21 82:61]
    node _GEN_6 = mux(_T_9, UInt<1>("h1"), UInt<1>("h0")) @[\\src\\main\\scala\\ControlUnit.scala 52:19 59:21 76:32]
    node _GEN_7 = mux(_T_9, UInt<1>("h0"), _GEN_4) @[\\src\\main\\scala\\ControlUnit.scala 51:19 59:21]
    node _GEN_8 = mux(_T_9, UInt<3>("h0"), _GEN_5) @[\\src\\main\\scala\\ControlUnit.scala 46:19 59:21]
    node _GEN_9 = mux(_T_8, UInt<3>("h0"), _GEN_8) @[\\src\\main\\scala\\ControlUnit.scala 59:21 74:40]
    node _GEN_10 = mux(_T_8, UInt<1>("h1"), UInt<1>("h0")) @[\\src\\main\\scala\\ControlUnit.scala 47:19 59:21 74:68]
    node _GEN_11 = mux(_T_8, UInt<1>("h0"), _GEN_6) @[\\src\\main\\scala\\ControlUnit.scala 52:19 59:21]
    node _GEN_12 = mux(_T_8, UInt<1>("h0"), _GEN_7) @[\\src\\main\\scala\\ControlUnit.scala 51:19 59:21]
    node _GEN_13 = mux(_T_7, UInt<1>("h1"), UInt<1>("h0")) @[\\src\\main\\scala\\ControlUnit.scala 49:19 59:21 72:36]
    node _GEN_14 = mux(_T_7, UInt<3>("h0"), _GEN_9) @[\\src\\main\\scala\\ControlUnit.scala 46:19 59:21]
    node _GEN_15 = mux(_T_7, UInt<1>("h0"), _GEN_10) @[\\src\\main\\scala\\ControlUnit.scala 47:19 59:21]
    node _GEN_16 = mux(_T_7, UInt<1>("h0"), _GEN_11) @[\\src\\main\\scala\\ControlUnit.scala 52:19 59:21]
    node _GEN_17 = mux(_T_7, UInt<1>("h0"), _GEN_12) @[\\src\\main\\scala\\ControlUnit.scala 51:19 59:21]
    node _GEN_18 = mux(_T_6, UInt<3>("h3"), _GEN_14) @[\\src\\main\\scala\\ControlUnit.scala 59:21 69:40]
    node _GEN_19 = mux(_T_6, UInt<1>("h1"), _GEN_15) @[\\src\\main\\scala\\ControlUnit.scala 59:21 69:70]
    node _GEN_20 = mux(_T_6, UInt<1>("h1"), _GEN_13) @[\\src\\main\\scala\\ControlUnit.scala 59:21 69:93]
    node _GEN_21 = mux(_T_6, UInt<1>("h0"), _GEN_13) @[\\src\\main\\scala\\ControlUnit.scala 49:19 59:21]
    node _GEN_22 = mux(_T_6, UInt<1>("h0"), _GEN_15) @[\\src\\main\\scala\\ControlUnit.scala 50:19 59:21]
    node _GEN_23 = mux(_T_6, UInt<1>("h0"), _GEN_16) @[\\src\\main\\scala\\ControlUnit.scala 52:19 59:21]
    node _GEN_24 = mux(_T_6, UInt<1>("h0"), _GEN_17) @[\\src\\main\\scala\\ControlUnit.scala 51:19 59:21]
    node _GEN_25 = mux(_T_5, UInt<3>("h2"), _GEN_18) @[\\src\\main\\scala\\ControlUnit.scala 59:21 68:40]
    node _GEN_26 = mux(_T_5, UInt<1>("h1"), _GEN_19) @[\\src\\main\\scala\\ControlUnit.scala 59:21 68:70]
    node _GEN_27 = mux(_T_5, UInt<1>("h1"), _GEN_20) @[\\src\\main\\scala\\ControlUnit.scala 59:21 68:93]
    node _GEN_28 = mux(_T_5, UInt<1>("h0"), _GEN_21) @[\\src\\main\\scala\\ControlUnit.scala 49:19 59:21]
    node _GEN_29 = mux(_T_5, UInt<1>("h0"), _GEN_22) @[\\src\\main\\scala\\ControlUnit.scala 50:19 59:21]
    node _GEN_30 = mux(_T_5, UInt<1>("h0"), _GEN_23) @[\\src\\main\\scala\\ControlUnit.scala 52:19 59:21]
    node _GEN_31 = mux(_T_5, UInt<1>("h0"), _GEN_24) @[\\src\\main\\scala\\ControlUnit.scala 51:19 59:21]
    node _GEN_32 = mux(_T_4, UInt<3>("h1"), _GEN_25) @[\\src\\main\\scala\\ControlUnit.scala 59:21 67:40]
    node _GEN_33 = mux(_T_4, UInt<1>("h1"), _GEN_26) @[\\src\\main\\scala\\ControlUnit.scala 59:21 67:70]
    node _GEN_34 = mux(_T_4, UInt<1>("h1"), _GEN_27) @[\\src\\main\\scala\\ControlUnit.scala 59:21 67:93]
    node _GEN_35 = mux(_T_4, UInt<1>("h0"), _GEN_28) @[\\src\\main\\scala\\ControlUnit.scala 49:19 59:21]
    node _GEN_36 = mux(_T_4, UInt<1>("h0"), _GEN_29) @[\\src\\main\\scala\\ControlUnit.scala 50:19 59:21]
    node _GEN_37 = mux(_T_4, UInt<1>("h0"), _GEN_30) @[\\src\\main\\scala\\ControlUnit.scala 52:19 59:21]
    node _GEN_38 = mux(_T_4, UInt<1>("h0"), _GEN_31) @[\\src\\main\\scala\\ControlUnit.scala 51:19 59:21]
    node _GEN_39 = mux(_T_3, UInt<3>("h0"), _GEN_32) @[\\src\\main\\scala\\ControlUnit.scala 59:21 66:40]
    node _GEN_40 = mux(_T_3, UInt<1>("h1"), _GEN_33) @[\\src\\main\\scala\\ControlUnit.scala 59:21 66:70]
    node _GEN_41 = mux(_T_3, UInt<1>("h1"), _GEN_34) @[\\src\\main\\scala\\ControlUnit.scala 59:21 66:93]
    node _GEN_42 = mux(_T_3, UInt<1>("h0"), _GEN_35) @[\\src\\main\\scala\\ControlUnit.scala 49:19 59:21]
    node _GEN_43 = mux(_T_3, UInt<1>("h0"), _GEN_36) @[\\src\\main\\scala\\ControlUnit.scala 50:19 59:21]
    node _GEN_44 = mux(_T_3, UInt<1>("h0"), _GEN_37) @[\\src\\main\\scala\\ControlUnit.scala 52:19 59:21]
    node _GEN_45 = mux(_T_3, UInt<1>("h0"), _GEN_38) @[\\src\\main\\scala\\ControlUnit.scala 51:19 59:21]
    node _GEN_46 = mux(_T_2, UInt<3>("h2"), _GEN_39) @[\\src\\main\\scala\\ControlUnit.scala 59:21 63:40]
    node _GEN_47 = mux(_T_2, UInt<1>("h1"), _GEN_41) @[\\src\\main\\scala\\ControlUnit.scala 59:21 63:67]
    node _GEN_48 = mux(_T_2, UInt<1>("h0"), _GEN_40) @[\\src\\main\\scala\\ControlUnit.scala 47:19 59:21]
    node _GEN_49 = mux(_T_2, UInt<1>("h0"), _GEN_42) @[\\src\\main\\scala\\ControlUnit.scala 49:19 59:21]
    node _GEN_50 = mux(_T_2, UInt<1>("h0"), _GEN_43) @[\\src\\main\\scala\\ControlUnit.scala 50:19 59:21]
    node _GEN_51 = mux(_T_2, UInt<1>("h0"), _GEN_44) @[\\src\\main\\scala\\ControlUnit.scala 52:19 59:21]
    node _GEN_52 = mux(_T_2, UInt<1>("h0"), _GEN_45) @[\\src\\main\\scala\\ControlUnit.scala 51:19 59:21]
    node _GEN_53 = mux(_T_1, UInt<3>("h1"), _GEN_46) @[\\src\\main\\scala\\ControlUnit.scala 59:21 62:40]
    node _GEN_54 = mux(_T_1, UInt<1>("h1"), _GEN_47) @[\\src\\main\\scala\\ControlUnit.scala 59:21 62:67]
    node _GEN_55 = mux(_T_1, UInt<1>("h0"), _GEN_48) @[\\src\\main\\scala\\ControlUnit.scala 47:19 59:21]
    node _GEN_56 = mux(_T_1, UInt<1>("h0"), _GEN_49) @[\\src\\main\\scala\\ControlUnit.scala 49:19 59:21]
    node _GEN_57 = mux(_T_1, UInt<1>("h0"), _GEN_50) @[\\src\\main\\scala\\ControlUnit.scala 50:19 59:21]
    node _GEN_58 = mux(_T_1, UInt<1>("h0"), _GEN_51) @[\\src\\main\\scala\\ControlUnit.scala 52:19 59:21]
    node _GEN_59 = mux(_T_1, UInt<1>("h0"), _GEN_52) @[\\src\\main\\scala\\ControlUnit.scala 51:19 59:21]
    node _GEN_60 = mux(_T, UInt<3>("h0"), _GEN_53) @[\\src\\main\\scala\\ControlUnit.scala 59:21 61:40]
    node _GEN_61 = mux(_T, UInt<1>("h1"), _GEN_54) @[\\src\\main\\scala\\ControlUnit.scala 59:21 61:67]
    node _GEN_62 = mux(_T, UInt<1>("h0"), _GEN_55) @[\\src\\main\\scala\\ControlUnit.scala 47:19 59:21]
    node _GEN_63 = mux(_T, UInt<1>("h0"), _GEN_56) @[\\src\\main\\scala\\ControlUnit.scala 49:19 59:21]
    node _GEN_64 = mux(_T, UInt<1>("h0"), _GEN_57) @[\\src\\main\\scala\\ControlUnit.scala 50:19 59:21]
    node _GEN_65 = mux(_T, UInt<1>("h0"), _GEN_58) @[\\src\\main\\scala\\ControlUnit.scala 52:19 59:21]
    node _GEN_66 = mux(_T, UInt<1>("h0"), _GEN_59) @[\\src\\main\\scala\\ControlUnit.scala 51:19 59:21]
    io_aluOperation <= _GEN_60
    io_immediate <= _GEN_62
    io_regWrite <= _GEN_61
    io_readData <= _GEN_63
    io_writeData <= _GEN_64
    io_branch <= _GEN_66
    io_jump <= _GEN_65
    io_start <= io_run @[\\src\\main\\scala\\ControlUnit.scala 55:12]
    io_stop <= isEnd @[\\src\\main\\scala\\ControlUnit.scala 56:12]
    io_done <= isEnd @[\\src\\main\\scala\\ControlUnit.scala 57:12]

  module ALU :
    input clock : Clock
    input reset : UInt<1>
    input io_sel : UInt<3> @[\\src\\main\\scala\\ALU.scala 33:14]
    input io_in1 : UInt<32> @[\\src\\main\\scala\\ALU.scala 33:14]
    input io_in2 : UInt<32> @[\\src\\main\\scala\\ALU.scala 33:14]
    output io_result : UInt<32> @[\\src\\main\\scala\\ALU.scala 33:14]
    output io_cmp : UInt<1> @[\\src\\main\\scala\\ALU.scala 33:14]

    node _T = eq(UInt<3>("h0"), io_sel) @[\\src\\main\\scala\\ALU.scala 45:18]
    node _io_result_T = add(io_in1, io_in2) @[\\src\\main\\scala\\ALU.scala 46:44]
    node _io_result_T_1 = tail(_io_result_T, 1) @[\\src\\main\\scala\\ALU.scala 46:44]
    node _T_1 = eq(UInt<3>("h1"), io_sel) @[\\src\\main\\scala\\ALU.scala 45:18]
    node _io_result_T_2 = sub(io_in1, io_in2) @[\\src\\main\\scala\\ALU.scala 47:44]
    node _io_result_T_3 = tail(_io_result_T_2, 1) @[\\src\\main\\scala\\ALU.scala 47:44]
    node _T_2 = eq(UInt<3>("h2"), io_sel) @[\\src\\main\\scala\\ALU.scala 45:18]
    node _io_result_T_4 = mul(io_in1, io_in2) @[\\src\\main\\scala\\ALU.scala 48:45]
    node _io_result_T_5 = bits(_io_result_T_4, 31, 0) @[\\src\\main\\scala\\ALU.scala 48:54]
    node _T_3 = eq(UInt<3>("h3"), io_sel) @[\\src\\main\\scala\\ALU.scala 45:18]
    node _T_4 = eq(UInt<3>("h4"), io_sel) @[\\src\\main\\scala\\ALU.scala 45:18]
    node _io_cmp_T = eq(io_in1, io_in2) @[\\src\\main\\scala\\ALU.scala 50:41]
    node _T_5 = eq(UInt<3>("h5"), io_sel) @[\\src\\main\\scala\\ALU.scala 45:18]
    node _io_cmp_T_1 = asSInt(io_in1) @[\\src\\main\\scala\\ALU.scala 53:41]
    node _io_cmp_T_2 = asSInt(io_in2) @[\\src\\main\\scala\\ALU.scala 53:57]
    node _io_cmp_T_3 = lt(_io_cmp_T_1, _io_cmp_T_2) @[\\src\\main\\scala\\ALU.scala 53:48]
    node _T_6 = eq(UInt<3>("h6"), io_sel) @[\\src\\main\\scala\\ALU.scala 45:18]
    node _io_cmp_T_4 = asSInt(io_in1) @[\\src\\main\\scala\\ALU.scala 54:41]
    node _io_cmp_T_5 = asSInt(io_in2) @[\\src\\main\\scala\\ALU.scala 54:57]
    node _io_cmp_T_6 = gt(_io_cmp_T_4, _io_cmp_T_5) @[\\src\\main\\scala\\ALU.scala 54:48]
    node _GEN_0 = mux(_T_6, _io_cmp_T_6, UInt<1>("h0")) @[\\src\\main\\scala\\ALU.scala 43:13 45:18 54:31]
    node _GEN_1 = mux(_T_5, _io_cmp_T_3, _GEN_0) @[\\src\\main\\scala\\ALU.scala 45:18 53:31]
    node _GEN_2 = mux(_T_4, _io_cmp_T, _GEN_1) @[\\src\\main\\scala\\ALU.scala 45:18 50:31]
    node _GEN_3 = mux(_T_3, io_in2, UInt<1>("h0")) @[\\src\\main\\scala\\ALU.scala 42:13 45:18 49:34]
    node _GEN_4 = mux(_T_3, UInt<1>("h0"), _GEN_2) @[\\src\\main\\scala\\ALU.scala 43:13 45:18]
    node _GEN_5 = mux(_T_2, _io_result_T_5, _GEN_3) @[\\src\\main\\scala\\ALU.scala 45:18 48:34]
    node _GEN_6 = mux(_T_2, UInt<1>("h0"), _GEN_4) @[\\src\\main\\scala\\ALU.scala 43:13 45:18]
    node _GEN_7 = mux(_T_1, _io_result_T_3, _GEN_5) @[\\src\\main\\scala\\ALU.scala 45:18 47:34]
    node _GEN_8 = mux(_T_1, UInt<1>("h0"), _GEN_6) @[\\src\\main\\scala\\ALU.scala 43:13 45:18]
    node _GEN_9 = mux(_T, _io_result_T_1, _GEN_7) @[\\src\\main\\scala\\ALU.scala 45:18 46:34]
    node _GEN_10 = mux(_T, UInt<1>("h0"), _GEN_8) @[\\src\\main\\scala\\ALU.scala 43:13 45:18]
    io_result <= _GEN_9
    io_cmp <= _GEN_10

  module CPUTop :
    input clock : Clock
    input reset : UInt<1>
    output io_done : UInt<1> @[\\src\\main\\scala\\CPUTop.scala 5:14]
    input io_run : UInt<1> @[\\src\\main\\scala\\CPUTop.scala 5:14]
    input io_testerDataMemEnable : UInt<1> @[\\src\\main\\scala\\CPUTop.scala 5:14]
    input io_testerDataMemAddress : UInt<16> @[\\src\\main\\scala\\CPUTop.scala 5:14]
    output io_testerDataMemDataRead : UInt<32> @[\\src\\main\\scala\\CPUTop.scala 5:14]
    input io_testerDataMemWriteEnable : UInt<1> @[\\src\\main\\scala\\CPUTop.scala 5:14]
    input io_testerDataMemDataWrite : UInt<32> @[\\src\\main\\scala\\CPUTop.scala 5:14]
    input io_testerProgMemEnable : UInt<1> @[\\src\\main\\scala\\CPUTop.scala 5:14]
    input io_testerProgMemAddress : UInt<16> @[\\src\\main\\scala\\CPUTop.scala 5:14]
    output io_testerProgMemDataRead : UInt<32> @[\\src\\main\\scala\\CPUTop.scala 5:14]
    input io_testerProgMemWriteEnable : UInt<1> @[\\src\\main\\scala\\CPUTop.scala 5:14]
    input io_testerProgMemDataWrite : UInt<32> @[\\src\\main\\scala\\CPUTop.scala 5:14]

    inst programCounter of ProgramCounter @[\\src\\main\\scala\\CPUTop.scala 23:30]
    inst dataMemory of DataMemory @[\\src\\main\\scala\\CPUTop.scala 24:26]
    inst programMemory of ProgramMemory @[\\src\\main\\scala\\CPUTop.scala 25:29]
    inst registerFile of RegisterFile @[\\src\\main\\scala\\CPUTop.scala 26:28]
    inst controlUnit of ControlUnit @[\\src\\main\\scala\\CPUTop.scala 27:27]
    inst alu of ALU @[\\src\\main\\scala\\CPUTop.scala 28:19]
    node _controlUnit_io_opcode_T = bits(programMemory.io_instructionRead, 31, 26) @[\\src\\main\\scala\\CPUTop.scala 56:39]
    node _registerFile_io_regin1_T = bits(programMemory.io_instructionRead, 25, 21) @[\\src\\main\\scala\\CPUTop.scala 60:40]
    node _registerFile_io_regin2_T = bits(programMemory.io_instructionRead, 20, 16) @[\\src\\main\\scala\\CPUTop.scala 61:40]
    node _registerFile_io_regin3_T = bits(programMemory.io_instructionRead, 25, 21) @[\\src\\main\\scala\\CPUTop.scala 64:16]
    node _registerFile_io_regin3_T_1 = bits(programMemory.io_instructionRead, 15, 11) @[\\src\\main\\scala\\CPUTop.scala 65:16]
    node _registerFile_io_regin3_T_2 = mux(controlUnit.io_branch, _registerFile_io_regin3_T, _registerFile_io_regin3_T_1) @[\\src\\main\\scala\\CPUTop.scala 62:32]
    node _immediate_T = bits(programMemory.io_instructionRead, 15, 15) @[\\src\\main\\scala\\CPUTop.scala 69:43]
    node _immediate_T_1 = mux(_immediate_T, UInt<16>("hffff"), UInt<16>("h0")) @[\\src\\main\\scala\\CPUTop.scala 69:27]
    node _immediate_T_2 = bits(programMemory.io_instructionRead, 15, 0) @[\\src\\main\\scala\\CPUTop.scala 69:61]
    node immediate = cat(_immediate_T_1, _immediate_T_2) @[\\src\\main\\scala\\CPUTop.scala 69:22]
    node _alu_io_in2_T = mux(controlUnit.io_immediate, immediate, registerFile.io_regout3) @[\\src\\main\\scala\\CPUTop.scala 74:20]
    node _dataMemory_io_address_T = bits(alu.io_result, 15, 0) @[\\src\\main\\scala\\CPUTop.scala 81:41]
    node _registerFile_io_writeSel_T = bits(programMemory.io_instructionRead, 20, 16) @[\\src\\main\\scala\\CPUTop.scala 88:16]
    node _registerFile_io_writeSel_T_1 = bits(programMemory.io_instructionRead, 25, 21) @[\\src\\main\\scala\\CPUTop.scala 89:16]
    node _registerFile_io_writeSel_T_2 = mux(controlUnit.io_readData, _registerFile_io_writeSel_T, _registerFile_io_writeSel_T_1) @[\\src\\main\\scala\\CPUTop.scala 86:34]
    node _registerFile_io_writeData_T = mux(controlUnit.io_readData, dataMemory.io_dataRead, alu.io_result) @[\\src\\main\\scala\\CPUTop.scala 91:35]
    node _programCounter_io_jump_T = and(controlUnit.io_branch, alu.io_cmp) @[\\src\\main\\scala\\CPUTop.scala 103:28]
    node _programCounter_io_jump_T_1 = or(controlUnit.io_jump, _programCounter_io_jump_T) @[\\src\\main\\scala\\CPUTop.scala 102:25]
    node _programCounter_io_programCounterJump_T = bits(programMemory.io_instructionRead, 15, 0) @[\\src\\main\\scala\\CPUTop.scala 104:54]
    io_done <= controlUnit.io_done @[\\src\\main\\scala\\CPUTop.scala 107:11]
    io_testerDataMemDataRead <= dataMemory.io_testerDataRead @[\\src\\main\\scala\\CPUTop.scala 47:28]
    io_testerProgMemDataRead <= programMemory.io_testerDataRead @[\\src\\main\\scala\\CPUTop.scala 41:28]
    programCounter.clock <= clock
    programCounter.reset <= reset
    programCounter.io_stop <= controlUnit.io_stop @[\\src\\main\\scala\\CPUTop.scala 100:26]
    programCounter.io_jump <= _programCounter_io_jump_T_1 @[\\src\\main\\scala\\CPUTop.scala 101:26]
    programCounter.io_run <= controlUnit.io_start @[\\src\\main\\scala\\CPUTop.scala 99:25]
    programCounter.io_programCounterJump <= _programCounter_io_programCounterJump_T @[\\src\\main\\scala\\CPUTop.scala 104:40]
    dataMemory.clock <= clock
    dataMemory.reset <= reset
    dataMemory.io_address <= _dataMemory_io_address_T @[\\src\\main\\scala\\CPUTop.scala 81:25]
    dataMemory.io_writeEnable <= controlUnit.io_writeData @[\\src\\main\\scala\\CPUTop.scala 83:29]
    dataMemory.io_dataWrite <= registerFile.io_regout2 @[\\src\\main\\scala\\CPUTop.scala 82:27]
    dataMemory.io_testerEnable <= io_testerDataMemEnable @[\\src\\main\\scala\\CPUTop.scala 49:30]
    dataMemory.io_testerAddress <= io_testerDataMemAddress @[\\src\\main\\scala\\CPUTop.scala 46:31]
    dataMemory.io_testerWriteEnable <= io_testerDataMemWriteEnable @[\\src\\main\\scala\\CPUTop.scala 50:35]
    dataMemory.io_testerDataWrite <= io_testerDataMemDataWrite @[\\src\\main\\scala\\CPUTop.scala 48:33]
    programMemory.clock <= clock
    programMemory.reset <= reset
    programMemory.io_address <= programCounter.io_programCounter @[\\src\\main\\scala\\CPUTop.scala 32:28]
    programMemory.io_testerEnable <= io_testerProgMemEnable @[\\src\\main\\scala\\CPUTop.scala 43:33]
    programMemory.io_testerAddress <= io_testerProgMemAddress @[\\src\\main\\scala\\CPUTop.scala 40:34]
    programMemory.io_testerWriteEnable <= io_testerProgMemWriteEnable @[\\src\\main\\scala\\CPUTop.scala 44:38]
    programMemory.io_testerDataWrite <= io_testerProgMemDataWrite @[\\src\\main\\scala\\CPUTop.scala 42:36]
    registerFile.clock <= clock
    registerFile.reset <= reset
    registerFile.io_regin1 <= _registerFile_io_regin1_T @[\\src\\main\\scala\\CPUTop.scala 60:26]
    registerFile.io_regin2 <= _registerFile_io_regin2_T @[\\src\\main\\scala\\CPUTop.scala 61:26]
    registerFile.io_regin3 <= _registerFile_io_regin3_T_2 @[\\src\\main\\scala\\CPUTop.scala 62:26]
    registerFile.io_writeSel <= _registerFile_io_writeSel_T_2 @[\\src\\main\\scala\\CPUTop.scala 86:28]
    registerFile.io_writeData <= _registerFile_io_writeData_T @[\\src\\main\\scala\\CPUTop.scala 91:29]
    registerFile.io_regWrite <= controlUnit.io_regWrite @[\\src\\main\\scala\\CPUTop.scala 96:28]
    controlUnit.clock <= clock
    controlUnit.reset <= reset
    controlUnit.io_opcode <= _controlUnit_io_opcode_T @[\\src\\main\\scala\\CPUTop.scala 56:25]
    controlUnit.io_run <= io_run @[\\src\\main\\scala\\CPUTop.scala 57:22]
    alu.clock <= clock
    alu.reset <= reset
    alu.io_sel <= controlUnit.io_aluOperation @[\\src\\main\\scala\\CPUTop.scala 72:14]
    alu.io_in1 <= registerFile.io_regout2 @[\\src\\main\\scala\\CPUTop.scala 73:14]
    alu.io_in2 <= _alu_io_in2_T @[\\src\\main\\scala\\CPUTop.scala 74:14]
