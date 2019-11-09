package com.davebsoft.sound

import com.illposed.osc.OSCMessage
import com.illposed.osc.transport.udp.OSCPortOut
import processing.core.PApplet
import java.net.InetAddress
import java.net.InetSocketAddress

class BubbleSortSonicPi : PApplet() {
    private val notes = mutableListOf(
        48, 50, 52, 55, 57, 60, 62, 64, 67, 69, 72)
    private val highestNote = notes.max()
    private val margin = 10f
    private val interBarSpacing = 2f
    private var verticalScale = 1f
    private val sonicPi = OSCPortOut(InetSocketAddress(
        InetAddress.getLocalHost(), 4559))

    override fun settings() {
        size(400, 200)
        val verticalSpace = height - 2 * margin
        verticalScale = verticalSpace / (highestNote ?: 1)
        notes.shuffle()
    }

    override fun setup() {
        surface.setTitle("Bubble Sort with Sonic Pi and Processing")
        fill(255f, 255f, 0f)
    }

    override fun draw() {
        frameRate(0.5f)
        translate(0f, height.toFloat())
        scale(1f, -1f)
        background(255f, 128f, 0f)
        if (!bubblePass())
            notes.shuffle()
        val space = width - 2 * margin
        val barWidth = space / notes.size
        notes.indices.map { i ->
            rect(margin + i * barWidth, margin,
                barWidth - interBarSpacing,
                verticalScale * notes[i].toFloat())
        }
        sonicPi.send(OSCMessage("/play", notes))
    }

    private fun bubblePass(): Boolean {
        (0 until notes.size - 1).forEach { i ->
            if (notes[i] > notes[i + 1]) {
                val temp = notes[i]
                notes[i] = notes[i + 1]
                notes[i + 1] = temp
                return true
            }
        }
        return false
    }
}

fun main() {
    PApplet.main("com.davebsoft.sound.BubbleSortSonicPi")
}
