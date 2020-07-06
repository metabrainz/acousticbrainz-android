#include <jni.h>
#include <string>
#include "extractors.h"

extern "C" JNIEXPORT jstring JNICALL
Java_org_metabrainz_essentiaandroid_MainActivity_stringFromJNI(
        JNIEnv* env,
        jobject /* this */) {
    std::string hello = "Hello from C++";
    return env->NewStringUTF(hello.c_str());
}

extern "C" string convertJStringToString(JNIEnv *env, jstring str) {
    jboolean is_copy;
    const char *CString = env->GetStringUTFChars(str, &is_copy);
    return std::string(CString);
}

extern "C"
JNIEXPORT jint JNICALL
Java_org_metabrainz_essentiaandroid_EssentiaJava_essentiaMusicExtractor(JNIEnv *env, jclass,
        jstring input_path, jstring output_path) {
    std::string input = convertJStringToString(env, input_path);
    std::string output = convertJStringToString(env, output_path);
    int returnCode = essentia_main(input, output, "");
    return returnCode;
}

extern "C"
JNIEXPORT jint JNICALL
Java_org_metabrainz_essentiaandroid_EssentiaJava_essentiaStandardMFCC(JNIEnv *env, jclass,
                                                                      jstring input_path,
                                                                      jstring output_path) {
    std::string input = convertJStringToString(env, input_path);
    std::string output = convertJStringToString(env, output_path);
    int returnCode = essentiaMFCC(input, output);
    return returnCode;
}