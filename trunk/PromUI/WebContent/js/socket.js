var socket;
var channel;
var processManager;
var programManager;
var windowManager;

Channel = function() {
	var waitingReqs = {};
	var errorReqs = {};
	var idCounter = 1;

	this.nextId = function() {
		idCounter = idCounter + 1;
		
		return idCounter + '';
	}
	
	this.rawSend = function(message, callback, error_callback) {
		if (!window.WebSocket) { return; }
		if (socket.readyState == WebSocket.OPEN) {
			waitingReqs[message[0].guid] = callback;
			errorReqs[message[0].guid] = error_callback;
			
			var json = JSON.stringify(message);
			//console.log(json);
			socket.send(json);
		} else {
			alert("The socket is not open.");
		}
	}
	
	var trapCallbackMap = {};
	
	this.registerTrap = function(method, callback) {
		var map = trapCallbackMap;
		map[method] = callback;
	}
	
	this.fireCallback = function(msg) {
		if(msg[0].type == 'Trap') {
			var map = trapCallbackMap;
			var method = msg[0].method;
			map[method](msg[1]);
		}
		else if(msg[0].type == 'Response') {
			var reqId = msg[0].requestId;
			
			// get and remove from waiting map
			var callback = waitingReqs[reqId];
			var error_callback = errorReqs[reqId];
			delete waitingReqs[reqId];
			delete errorReqs[reqId];
			
			if(!!msg[0].errorMessage) {
				if(error_callback != null) {
					error_callback(msg[0]);
				}
				else { 
					console.log('An error occurred from ' + msg[0].method);
					console.log(msg);
				}
			}
			else {
				// invoke callback
				callback(msg[1]);
			}
		}		
	}
	
	this.onreceive = function(data) {
		//console.log(data);
		var msg = JSON.parse(data);
		
		this.fireCallback(msg);
	}
	
	this.send = function(pid, method, params, callback, error_callback) {
		var guid = this.nextId();
		
		var msg = [ 
			{ 
				"guid": guid,
				"type": "Request",
				"source": pid,
				"target": null,
				"method": method
			}, 
			params 
		];
		
		this.rawSend(msg, callback, error_callback);
	}
}

LoginPage = function() {}

LoginPage.initialize = function() {
	$("#username").val("root");
	$("#password").val("prom");
	
	$("#username").focus(function() { $("#login-err").hide(); });
	$("#password").focus(function() { $("#login-err").hide(); })
				  .keypress(function(e) {
					if (e.keyCode == '13') {
						$("#login button").click();
					}
				  });
	
	$("#username").focus();
	
	$("#login button").click(function() {

		var username = $("#username").val();
		var password = $("#password").val();
		
		var token = { "user": username, "password": password };
		
		channel.send(1, "kr.cyberone.prom.admin.msgbus.LoginPlugin.login", token, function(resp) {
			resp.locale = 'en';
			
			programManager.setLocale(resp.locale);
			
			if(resp.result) {
				$('.fullmask').fadeOut('fast', function() {
					$('.fullmask').remove();
					$('#main').hide().load('/start.html', StartPage.initialize); 
				});
				
			}
			else {
				$("#password").val('');
				$("#login-err").show('highlight');
			}
		});
		//$('#main').load('/start.html', StartPage.initialize); 
	});
}

$.fn.setCellsize = function(w, h) {
	this.css('width', w + 'em');
	this.css('height', h + 'em');
	this.css('margin-left', -(w/2) + 'em');
	this.css('margin-top', -(h/2) + 'em');
	
	return this;
}

if (window.WebSocket) {
	socket = new WebSocket("ws://" + window.location.host + "/websocket");
	socket.onmessage = function(event) { 
		/* alert('received: ' + event.data); */ 
		channel.onreceive(event.data);
	};
	socket.onopen = function(event) { 
		$('#main loading-indicator').remove();
		$('#main').load('/login.html', LoginPage.initialize);
		
		channel = new Channel();
	};
	socket.onerror = function(error) {
		console.error(error);
	};
	
	var closeContent = "";
	$.get('close.html', function(data) {
		closeContent = data;
	});
	
	socket.onclose = function(event) {
		onClose();
	};
} else {
	//alert("Your browser does not support Web Socket.");
	$('#bartop').load('top_bar.html', LoginPage.initialize);	
	
	channel = new Channel();
	
}

