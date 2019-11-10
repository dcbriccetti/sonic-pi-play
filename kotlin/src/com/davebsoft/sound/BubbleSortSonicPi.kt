package com.davebsoft.sound

import com.illposed.osc.OSCMessage
import com.illposed.osc.transport.udp.OSCPortOut
import processing.core.PApplet
import java.net.InetAddress
import java.net.InetSocketAddress

const val MIN_BAR_HEIGHT = 4
const val MARGIN = 10f
const val INTER_BAR_SPACING = 2f
const val REST_BEATS = 4
const val MIN_BPM = 60f
const val DEFAULT_BPM = 300f
const val MAX_BPM = 2000f

class BubbleSortSonicPi : PApplet() {
    private val notes = mutableListOf(
        48, 50, 52, 55, 57, 60, 62, 64, 67, 69, 72)
    private val highestNote = notes.max() ?: 0
    private val lowestNote  = notes.min() ?: 0
    private val barHeightDecrease = lowestNote - MIN_BAR_HEIGHT
    private var verticalScale = 1f
    private var barWidth = 0f
    private var mouseHasMoved = false // Ignore mouse position until it’s moved
    private val sonicPi = OSCPortOut(InetSocketAddress(
        InetAddress.getLocalHost(), 4559))

    override fun settings() {
        size(400, 200)
    }

    override fun setup() {
        val verticalSpace = height - 2 * MARGIN
        verticalScale = verticalSpace / (highestNote - barHeightDecrease)
        val horizontalSpace = width - 2 * MARGIN
        barWidth = horizontalSpace / notes.size
        notes.shuffle()
        surface.setTitle("Bubble Sort with Sonic Pi and Processing")
        fill(255f, 255f, 0f)
    }

    var sleepTill = System.currentTimeMillis()

    override fun draw() {
        if (System.currentTimeMillis() < sleepTill) return
        frameRate(10f)
        setUpQuadrantOne()
        background(255f, 128f, 0f)

        if (!bubblePass()) // Take a pass and do one swap, and if done, reset
            notes.shuffle()

        drawNotes()

        val bpm = if (mouseHasMoved) map(mouseX.toFloat(), 0f, width - 1f, MIN_BPM, MAX_BPM) else DEFAULT_BPM
        sonicPi.send(OSCMessage("/play", listOf(bpm, notes)))
        val secsPerPlay = (notes.size + REST_BEATS) / bpm * 60
        sleepTill = System.currentTimeMillis() + (secsPerPlay * 1000).toLong()
    }

    override fun mouseMoved() {
        mouseHasMoved = true
    }

    /** Draws a rectangle for each note */
    private fun drawNotes() {
        notes.indices.map { i ->
            rect(MARGIN + i * barWidth, MARGIN,
                    barWidth - INTER_BAR_SPACING,
                    verticalScale * (notes[i].toFloat() - barHeightDecrease))
        }
    }

    /** Brings the origin to the bottom left, and makes y increase going up */
    private fun setUpQuadrantOne() {
        translate(0f, height.toFloat())
        scale(1f, -1f)
    }

    /**
     * Takes a single pass through the notes and makes at most one swap.
     * Returns whether a swap was made.
     */
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
