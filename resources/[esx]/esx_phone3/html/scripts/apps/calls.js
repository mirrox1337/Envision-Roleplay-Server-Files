(function(){

	Phone.apps['calls'] = {};
	const app = Phone.apps['calls'];
	const MAX_CONTACTS_ON_SCREEN = 16;
	const messageListTpl = '{{#list}}<div class="contact" data-name="{{name}}" data-number="{{number}}" data-timestamp"{{timestamp}}"><div class="contact-name">{{message}} <br> {{name}} <br>{{timestamp}}</div></div>{{/list}}';
	let currentRow = 0;
	let currentContact = {};

	app.open = function(data) {

		currentRow = 0;

		app.updateMessages();

		$('.status-bar').css("background-color", "");
		$('.status-bar').css("color", "");
		const elems = $('#app-calls .contact');

		if(elems.length > 0)
			app.selectElem(elems[0]);

	}

	app.move = function(direction) {

		const elems = $('#app-calls .contact');

		switch(direction) {

			case 'TOP': {

				if(currentRow > 0)
					currentRow--;

				break;
			}

			case 'DOWN': {

				if(currentRow + 1 < elems.length)
					currentRow++;

				break;
			}

			default: break;

		}

		elems.show();

		let diff = currentRow - MAX_CONTACTS_ON_SCREEN + 2;

		if(diff > 0) {

			for(let i=0; i<diff; i++)
				$(elems[i]).hide();

		}

		app.selectElem(elems[currentRow]);

	}

	app.enter = function() {
		$('.status-bar').css("background-color", "");
		$('.status-bar').css("color", "");
		if(Phone.calls.length !== 0){
			Phone.open('contact-action-call', currentContact);
		}
	}

	app.selectElem = function(elem) {
		
		const elems = $('#app-calls .contact');
		currentContact.name = $(elem).data('name');
		currentContact.number = $(elem).data('number');
		currentContact.timestamp = $(elem).data('timestamp');

		elems.removeClass('selected');

		$(elem).addClass('selected');
	}
	
	app.updateMessages = function () {

		const contacts = {};
		const list = [];

		for (let i = 0; i < Phone.calls.length; i++) {

			//if (Phone.messages[i].self)
				//continue;

			const number = Phone.calls[i].number;
			
			

			if (typeof contacts[number] == 'undefined')
				contacts[number] = { unread: 0, timestamp: 0 };

			if (!Phone.calls[i].read)
				contacts[number].unread++;
			
			
			contacts[number].timestamp = Phone.calls[i].timestamp;
			contacts[number].message = Phone.calls[i].message
	
			if (Phone.calls[i].timestamp > contacts[number].timestamp)
				contacts[number].timestamp = Phone.calls[i].timestamp;

		}

		for (let k in contacts) {
			if (contacts.hasOwnProperty(k)) {
				list.push({
					["name"]: app.getContactName(k),
					["number"]: k,
					["unread"]: contacts[k].unread,
					["timestamp"]: contacts[k].timestamp,
					["message"]: contacts[k].message
				});
			}
		}

		list.sort((a, b) => b.timestamp - a.timestamp);

		const html = Mustache.render(messageListTpl, { list });

		$('#app-calls .contact-list').html(html);
	}

	app.getContactName = function(number) {

		if(number == '-1')
			return 'Anonym';

		for(let i=0; i<Phone.contacts.length; i++)
			if(Phone.contacts[i].number == number)
				return Phone.contacts[i].name;

		const elems = $('#app-home .menu-icon[data-app="contact-action-message"]');

		for(let i=0; i<elems.length; i++)
			if($(elems[i]).data('args').number == number)
				return $(elems[i]).data('args').name;

		return number;
	}

})();

