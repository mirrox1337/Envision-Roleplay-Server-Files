(function () {

	Phone.apps['twitter'] = {};
	const app = Phone.apps['twitter'];

	const twitterTpl = '{{#messages}}<div class="time">{{time}}</div><div class="message">{{body}}</div>{{/messages}}';

	let characterName = "";
	let isTypingTwitter = false;

	app.open = function() {

		isTypingTwitter = false;

		app.updatTweets();

		$('#app-twitter .message-input textarea[name="message"]').removeClass('typing');

		setTimeout(() => {
			$('#app-twitter .message-input textarea[name="message"]').focus();
			$('#app-twitter .message-actions')[0].scrollIntoView();
		}, 50);
	}

	app.close = function () {

		if (isTypingTwitter) {
			isTypingTwitter = false;
			$('#app-twitter .message-input textarea[name="message"]').removeClass('typing');
			$.post('http://esx_phone3/release_focus');

			return false;
		} else {
			return true;
		}
	}

	app.move = function (direction) {

		const scrollable = $('#app-twitter .app-inner')[0];

		switch (direction) {

			case 'TOP': {
				scrollable.scrollTop -= 15;
				break;
			}

			case 'DOWN': {
				scrollable.scrollTop += 15;
				break;
			}

			default: break;

		}
	}

	app.enter = function () {

		if (isTypingTwitter) {
			if ($('#app-twitter .message-input textarea[name="message"]').val().replace(/\s/g, '').length) {
				const date = new Date;
				
				if ($('input[name="anon"]').is(':checked')) {
					msg = "@Anonym " + $('#app-twitter .message-input textarea[name="message"]').val();
				} else {
					msg = "" + characterName + ":  " + $('#app-twitter .message-input textarea[name="message"]').val();
				}

				const currentDate = date.toISOString().substring(0, 10) + " " + date.getHours().toString().padStart(2, '0') + ':' + date.getMinutes().toString().padStart(2, '0');

				Phone.tweets.push({
					["time"]: currentDate,
					["body"]: msg,
					["read"]: true,
				});

				$.post('http://esx_phone3/tweet', JSON.stringify({
					["message"]: msg,
					["date"]: currentDate
				}));

				app.updatTweets();

				$('#app-twitter .message-dialog').hide();
				$('#app-twitter .message-input textarea[name="message"]').val('');
				$('#app-twitter .message-input textarea[name="message"]').focus();
				$('#app-twitter .message-input textarea[name="message"]').removeClass('typing');
				$('#app-twitter .message-actions')[0].scrollIntoView();

				isTypingTwitter = false;

				$.post('http://esx_phone3/release_focus');
			} else {
				isTypingTwitter = false;
				$('#app-twitter .message-input textarea[name="message"]').val('');
				$('#app-twitter .message-input textarea[name="message"]').removeClass('typing');
				$.post('http://esx_phone3/release_focus');
			}

		} else {

			isTypingTwitter = true;
			$('#app-twitter .message-input textarea[name="message"]').addClass('typing');
			$.post('http://esx_phone3/request_focus');
		}
	}

	app.updatTweets = function() {

		const messages = Phone.tweets;

		for (let i = 0; i < messages.length; i++) {
			messages[i].read = true;
		}

		const html = Mustache.render(twitterTpl, { messages });

		$('#app-twitter .message-container').html(html);
	}

	app.registerCharacterName = function(name) {
		characterName = name;
	}

})();