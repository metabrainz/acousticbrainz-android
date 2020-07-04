cmake_minimum_required(VERSION 3.10.2)

project("essentiaandroid")

add_library(native-lib
            SHARED
            native-lib.cpp credit_libav.h
            streaming_extractor_music.cpp streaming_extractor_music.h
            extractor_utils.cpp extractor_utils.h)

add_library(essentia STATIC IMPORTED)
add_library(avformat STATIC IMPORTED)
add_library(avcodec STATIC IMPORTED)
add_library(avutil STATIC IMPORTED)
add_library(avresample STATIC IMPORTED)
add_library(samplerate STATIC IMPORTED)
add_library(mp3lame STATIC IMPORTED)
add_library(chromaprint STATIC IMPORTED)
add_library(tag STATIC IMPORTED)
add_library(yaml SHARED IMPORTED)

set_target_properties(  essentia
                        PROPERTIES IMPORTED_LOCATION
                        ${CMAKE_SOURCE_DIR}/../jniLibs/${ANDROID_ABI}/lib/libessentia.a)

set_target_properties(  avformat
                        PROPERTIES IMPORTED_LOCATION
                        ${CMAKE_SOURCE_DIR}/../jniLibs/${ANDROID_ABI}/lib/libavformat.a)

set_target_properties(  avcodec
                        PROPERTIES IMPORTED_LOCATION
                        ${CMAKE_SOURCE_DIR}/../jniLibs/${ANDROID_ABI}/lib/libavcodec.a)

set_target_properties(  avutil
                        PROPERTIES IMPORTED_LOCATION
                        ${CMAKE_SOURCE_DIR}/../jniLibs/${ANDROID_ABI}/lib/libavutil.a)

set_target_properties(  avresample
                        PROPERTIES IMPORTED_LOCATION
                        ${CMAKE_SOURCE_DIR}/../jniLibs/${ANDROID_ABI}/lib/libavresample.a)

set_target_properties(  samplerate
                        PROPERTIES IMPORTED_LOCATION
                        ${CMAKE_SOURCE_DIR}/../jniLibs/${ANDROID_ABI}/lib/libsamplerate.a)

set_target_properties(  mp3lame
                        PROPERTIES IMPORTED_LOCATION
                        ${CMAKE_SOURCE_DIR}/../jniLibs/${ANDROID_ABI}/lib/libmp3lame.a)

set_target_properties(  chromaprint
                        PROPERTIES IMPORTED_LOCATION
                        ${CMAKE_SOURCE_DIR}/../jniLibs/${ANDROID_ABI}/lib/libchromaprint.a)

set_target_properties(  tag
                        PROPERTIES IMPORTED_LOCATION
                        ${CMAKE_SOURCE_DIR}/../jniLibs/${ANDROID_ABI}/lib/libtag.a)

set_target_properties(  yaml
                        PROPERTIES IMPORTED_LOCATION
                        ${CMAKE_SOURCE_DIR}/../jniLibs/${ANDROID_ABI}/lib/libyaml-0.so)

include_directories(${CMAKE_SOURCE_DIR}/../jniLibs/include)
include_directories(${CMAKE_SOURCE_DIR}/../jniLibs/include/eigen3)

find_library(log-lib log)
find_library(math-lib m)
find_library(zlib z)

target_link_libraries(native-lib essentia avresample avformat avcodec avutil mp3lame
                      yaml chromaprint tag samplerate ${log-lib} ${math-lib} ${zlib})