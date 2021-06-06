package org.metabrainz.essentiaandroid

import android.content.Context
import androidx.work.Worker
import androidx.work.WorkerParameters

class AudioAnalysisWorker(context: Context, workerParams: WorkerParameters) : Worker(context, workerParams) {
    override fun doWork(): Result {
        val inputPath = inputData.getString(INPUT_PATH)
        val outputPath = inputData.getString(OUTPUT_PATH)
        val result = EssentiaJava.essentiaMusicExtractor(inputPath, outputPath)
        return if (result != 0) Result.failure() else Result.success()
    }

    companion object {
        const val INPUT_PATH = "input"
        const val OUTPUT_PATH = "output"
    }
}