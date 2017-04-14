
'use strict';

import {NativeModules, Platform } from 'react-native';
var qrdecoder = NativeModules.QrDecoder;

class QRDecoder {
	get(path,callback) {
		qrdecoder.get(path, (error, qrcode) => {
		    callback(error,qrcode)
		})	
	}
}

module.exports = QRDecoder;