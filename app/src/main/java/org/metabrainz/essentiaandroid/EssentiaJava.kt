package org.metabrainz.essentiaandroid

object EssentiaJava {
    external fun essentiaMusicExtractor(inputPath: String?, outputPath: String?): Int
    external fun essentiaStandardMFCC(inputPath: String?, outputPath: String?): Int
}