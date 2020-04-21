package me.codingfd.myapplication

import android.animation.ValueAnimator
import android.content.Context
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.os.Looper
import android.util.AttributeSet
import android.util.Log
import android.view.View
import androidx.core.animation.addListener
import java.util.*
import java.util.logging.Handler
import kotlin.concurrent.timer
import kotlin.random.Random

/**
 *  author: coding_fd
 *  time  : 2020/4/20
 *  -----------------
 *  description:
 */
class LiveChart : View {


    private val paint by lazy {
        Paint().apply {
            color = Color.BLACK
            strokeWidth = 3F
            textSize = 32F
        }
    }

    val list by lazy {
        mutableListOf(
            Data(0F, "用户1", 80F, Color.BLUE),
            Data(1F, "用户2", 60F, Color.YELLOW),
            Data(2F, "用户3", 40F, Color.RED),
            Data(3F, "用户4", 20F, Color.GRAY),
            Data(4F, "用户5", 10F, Color.GREEN)
        )
    }

    constructor(context: Context?) : super(context)
    constructor(context: Context?, attrs: AttributeSet?) : super(context, attrs)
    constructor(context: Context?, attrs: AttributeSet?, defStyleAttr: Int) : super(
        context,
        attrs,
        defStyleAttr
    )

    override fun onFinishInflate() {
        super.onFinishInflate()
        loop()
    }

    private fun loop() {
        Handler.postDelayed(
            {
                list.forEach { item ->
                    item.change()
                }
                list.sortBy { it.targetValue }
                list.forEachIndexed { index, data ->
                    data.targetIndex = index.toFloat();
                }
                ValueAnimator.ofFloat(0F, 1F).apply {
                    duration = 1000
                    addUpdateListener { animator ->
                        val value = animator.animatedValue as Float
                        list.forEach { item ->
                            item.value =
                                item.originalValue + (item.targetValue - item.originalValue) * value
                            item.index =
                                item.originalIndex + (item.targetIndex - item.originalIndex) * value
                        }
                        postInvalidate()
                    }
                    addListener(onEnd = {
                        list.forEach { item ->
                            item.index = item.targetIndex
                            item.originalIndex = item.targetIndex
                            item.value = item.targetValue
                            item.originalValue = item.targetValue

                        }
                    })
                }.start()
                loop()
            }, 5000
        )
    }


    override fun onDraw(canvas: Canvas?) {
        super.onDraw(canvas)
        if (canvas == null)
            return
        val start = 100F
        val averageHeight = height / 5
        val height = averageHeight / 3;

        for (i in 0 until 5) {
            val item = list[i];
            val left = start
            val top = item.index * averageHeight + (averageHeight - height) / 2
            val right = start + width * item.value / 100
            val bottom = top + height
            paint.color = list[i].color
            canvas.drawRect(left, top, right, bottom, paint)
            paint.color = Color.GRAY
            canvas.drawText(
                list[i].label,
                0F,
                ((top + bottom) / 2) + paint.textSize / 2,
                paint
            )
        }
        paint.color = Color.GRAY

        canvas.drawLine(start, 0F, start, bottom.toFloat(), paint)


    }


    class Data(
        var index: Float,
        var label: String,
        var value: Float,
        var color: Int
    ) {
        var originalValue = value
        var targetValue = value

        var originalIndex = index
        var targetIndex = index

        fun change() {
            targetValue = Random.nextInt(80).toFloat()
        }
    }


    companion object {
        val Handler = android.os.Handler(Looper.getMainLooper())
    }
}