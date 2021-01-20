(function(){

	Phone.apps['contacts']       = {};
	const app                    = Phone.apps['contacts'];
	const MAX_CONTACTS_ON_SCREEN = 14;
	const contactTpl             = '{{#contacts}}<div class="contact" data-name="{{name}}" data-number="{{number}}"><div class="contact-name">{{name}}</div><div class="contact-number">{{number}}</div></div>{{/contacts}}';
	let currentRow               = 0;
	let currentAction            = 'contact';
	const currentContact         = {};

	app.open = function(data) {

		$('.status-bar').css("background-color", "");
		$('.status-bar').css("color", "");

		currentRow = 0;
		const html = Mustache.render(contactTpl, {contacts: Phone.contacts});

		$('#app-contacts .contact-list').html(html);

		const elems = $('#app-contacts .contact-actions div, #app-contacts .contact-list .contact');

		if(elems.length > 1)
			app.selectElem(elems[1]);
		else
			app.selectElem(elems[0]);

	}

	app.move = function(direction) {

		const elems = $('#app-contacts .contact-actions div, #app-contacts .contact-list .contact');

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

		switch(currentAction) {

			case 'add-contact' : {
				
				$('.status-bar').css("background-color", "#");
				$('.status-bar').css("color", "");

				Phone.open('contact-add'); 
				break;
			}

			case 'contact' : {

				$('.status-bar').css("background-color", "");
				$('.status-bar').css("color", "");

				Phone.open('contact-actions', currentContact);
				break;
			}

			default : break;

		}

	}

	app.selectElem = function(elem) {
		
		const elems = $('#app-contacts .contact-actions div, #app-contacts .contact-list .contact');
		
		if($(elem).hasClass('contact')) {

			currentAction         = 'contact';
			currentContact.name   = $(elem).data('name');
			currentContact.number = $(elem).data('number');
		
		}

		if($(elem).hasClass('add-contact')) {
			currentAction = 'add-contact'
		}

		elems.removeClass('selected');

		$(elem).addClass('selected');
	}

})();