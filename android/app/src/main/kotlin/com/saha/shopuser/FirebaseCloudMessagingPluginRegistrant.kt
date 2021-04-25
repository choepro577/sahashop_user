package com.saha.shopuser

import io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin


object FirebaseCloudMessagingPluginRegistrant {
    fun registerWith(registry: io.flutter.plugin.common.PluginRegistry) {
        if (alreadyRegisteredWith(registry)) {
            return
        }
        FirebaseMessagingPlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"))
    }

    private fun alreadyRegisteredWith(registry: io.flutter.plugin.common.PluginRegistry): Boolean {
        val key: String = FirebaseCloudMessagingPluginRegistrant::class.java.getCanonicalName()
        if (registry.hasPlugin(key)) {
            return true
        }
        registry.registrarFor(key)
        return false
    }
}