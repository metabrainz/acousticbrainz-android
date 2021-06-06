package org.metabrainz.essentiaandroid

object EssentiaKotlin {
    external fun essentiaMusicExtractor(inputPath: String?, outputPath: String?): Int
    external fun essentiaStandardMFCC(inputPath: String?, outputPath: String?): Int
}