package org.metabrainz.acousticbrainz

object AcousticBrainzClient {
    /**
     * Processes the input audio file using
     * [Essentia's Streaming
     * Extractor Music](https://essentia.upf.edu/streaming_extractor_music.html) program and produces set of low-level and high-level data that can be
     * submitted to [AcousticBrainz]().
     * @param inputPath absolute path to audio file to be processed
     * @param outputPath absolute path to json file to which data should be written
     * @return 0 or 1 depending on whether process completes successfully or not
     */
    external fun extractData(inputPath: String?, outputPath: String?): Int

    init {
        System.loadLibrary("acousticbrainz")
    }
}