(function(){

	Phone.apps['contact-actions'] = {};
	const app = Phone.apps['contact-actions'];

	let currentCol = 0;
	let currentAction;
	let currentContact;

	app.open = function(contact) {

		currentContact = contact;
		currentCol = 0;
		const elems = $('#app-contact-actions .contact-action');

		$('#app-contact-actions .contact-name').text(contact.name);
		$('#app-contact-actions .contact-number').text(contact.number);

		if(elems.length > 0)
			app.selectElem(elems[0]);

	}

	app.move = function(direction) {

		const elems = $('#app-contact-actions .contact-action');

		switch(direction) {

			case 'LEFT': {

				if(currentCol > 0)
					currentCol--;

				break;
			}

			case 'RIGHT': {

				if(currentCol + 1 < elems.length)
					currentCol++;

				break;
			}

			default: break;

		}

		app.selectElem(elems[currentCol]);

	}

	app.close = function() {

		$('.status-bar').css("background-color", "");
		$('.status-bar').css("color", "");
		
		return true
	}

	app.enter = function() {

		switch(currentAction) {

			case 'call' : {
				Phone.open('contact-action-call', currentContact)
				break;
			}

			case 'message' : {
				Phone.open('contact-action-message', currentContact)
				break;
			}
			
			case 'remove' : {
                $.post('http://esx_phone3/remove_contact', JSON.stringify(currentContact));
                break;
			}
			
			case 'swish' : {
				Phone.open('bank-transfer-menu');

				$('#app-bank-transfer-menu input[name="transfer-receiver"]').val(currentContact.number);
                break;
            }

			default: break;

		}

	}

	app.selectElem = function(elem) {
		
		const elems = $('#app-contact-actions .contact-action');

		currentAction = $(elem).data('action');

		elems.removeClass('selected animated pulse infinite');

		$(elem).addClass('selected animated pulse infinite');
	}

})();