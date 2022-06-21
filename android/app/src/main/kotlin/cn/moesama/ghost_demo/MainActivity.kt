package cn.moesama.ghost_demo

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import io.flutter.embedding.android.FlutterFragment
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel

class MainActivity: AppCompatActivity() {
    private lateinit var flutterEngine: FlutterEngine
    private var flutterFragment: FlutterFragment? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        flutterEngine = FlutterEngine(applicationContext)

        // Start executing Dart code in the FlutterEngine.
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { methodCall, result ->
            if (methodCall.method == "backDesktop") {
                result.success(true)
                moveTaskToBack(false)
            }
        } // Cache the FlutterEngine to be used by FlutterActivity or FlutterFragment.
        FlutterEngineCache
            .getInstance()
            .put("my_engine_id", flutterEngine)

        flutterFragment = supportFragmentManager
            .findFragmentByTag(TAG_FLUTTER_FRAGMENT) as FlutterFragment?
        // Create and attach a FlutterFragment if one does not exist.
        if (flutterFragment == null) {
            flutterFragment =
                FlutterFragment.withCachedEngine("my_engine_id").shouldAttachEngineToActivity(true)
//                    .transparencyMode(TransparencyMode.opaque)
                    .build()
            supportFragmentManager
                .beginTransaction()
                .add(
                    R.id.flutter,
                    flutterFragment!!,
                    TAG_FLUTTER_FRAGMENT
                )
                .commit()
        }
    }

    companion object {
        //通讯名称,回到手机桌面
        private const val CHANNEL = "android/back/desktop"
        private const val TAG_FLUTTER_FRAGMENT = "flutter_fragment"
    }
}
