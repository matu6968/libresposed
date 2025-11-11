package com.berdik.macsposed.utils

import com.berdik.macsposed.BuildConfig
import com.topjohnwu.superuser.Shell

object RootPermissionRequester {
    private var hasRequested = false

    init {
        Shell.enableVerboseLogging = BuildConfig.DEBUG
    }

    fun requestRootAccess() {
        if (hasRequested) {
            return
        }

        hasRequested = true
        Shell.getShell { _ -> }
    }
}
