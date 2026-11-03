import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import java.util

object Programs{
  val program1 = Array(
    "hXXXXXXXX".U(32.W), // instruction 1
    "hXXXXXXXX".U(32.W), // instruction 2
    "hXXXXXXXX".U(32.W), // instruction 3
    "hXXXXXXXX".U(32.W)  // END instruction
  )

  val program2 = Array(
    "h00000000".U(32.W),
    "h00000000".U(32.W),
    "h00000000".U(32.W),
    "h00000000".U(32.W),
    "h00000000".U(32.W),
    "h00000000".U(32.W),
    "h00000000".U(32.W),
    "h00000000".U(32.W),
    "h00000000".U(32.W),
    "h00000000".U(32.W),
    "h00000000".U(32.W),
    "h00000000".U(32.W)
  )
}