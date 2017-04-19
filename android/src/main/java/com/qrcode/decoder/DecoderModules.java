package com.qrcode.decoder;

import android.text.TextUtils;
import android.os.AsyncTask;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.google.zxing.Result;
//import com.qrcode.decoder.Decoder;

/**
 * Created by derrick on 18/04/17.
 */

public class DecoderModules extends ReactContextBaseJavaModule {
    public DecoderModules(ReactApplicationContext reactContext){
        super(reactContext);
    }
    @Override
    public String getName() {
        return "QrDecoder";
    }
    @ReactMethod
    public void get(final String path,final Callback callback){
        new AsyncTask<Void,Void,Result>(){
            @Override
            protected Result doInBackground(Void... params){
                return Decoder.syncDecodeQRCode(path);
            }

            @Override
            protected void onPostExecute(Result result) {
                if(result == null){
                    callback.invoke(-1,"error");
                }
                if (TextUtils.isEmpty(result.getText())) {
                    //Toast.makeText(TestGeneratectivity.this, errorTip, Toast.LENGTH_SHORT).show();
                    callback.invoke(-1,"error");
                } else {
                    //Toast.makeText(TestGeneratectivity.this, result, Toast.LENGTH_SHORT).show();
                    callback.invoke(0, result.getText());
                }
            }
        }.execute();
    }
    
}
