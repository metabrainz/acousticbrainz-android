#include <jni.h>
#include <string>
#include "streaming_extractor_music.h"

extern "C" JNIEXPORT jstring JNICALL
Java_org_metabrainz_essentiaandroid_MainActivity_stringFromJNI(
        JNIEnv* env,
        jobject /* this */) {
    std::string hello = "Hello from C++";
    return env->NewStringUTF(hello.c_str());
}

extern "C"
JNIEXPORT jint JNICALL
Java_org_metabrainz_essentiaandroid_MainActivity_essentiaMusicExtractor(JNIEnv *env, jobject thiz,
        jstring input_path, jstring output_path) {
    jboolean is_copy;
    const char *convertedInputPath = env->GetStringUTFChars(input_path, &is_copy);
    const char *convertedOutputPath = env->GetStringUTFChars(output_path, &is_copy);
    std::string input = std::string(convertedInputPath);
    std::string output = std::string(convertedOutputPath);
    int returnCode = essentia_main(input, output);
    return returnCode;
}