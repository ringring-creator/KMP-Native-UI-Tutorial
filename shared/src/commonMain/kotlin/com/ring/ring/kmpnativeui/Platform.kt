package com.ring.ring.kmpnativeui

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform