(function(){

	Phone.apps['bank-transfer-menu'] = {};
	const app = Phone.apps['bank-transfer-menu'];

	app.open = function(contact) {

		const elems = $('#app-bank-transfer-menu .transfer-wrapper div input')

		elems.val('');

		setTimeout(() => {
			$(elems[0]).focus();
		}, 50);

		$.post('http://esx_phone3/request_focus');

	}

	app.close = function() {
		$.post('http://esx_phone3/release_focus');
		return true;
	}

	app.move = function(direction) {
	}

	app.enter = function() {

		const elems = $('#app-bank-transfer-menu .transfer-wrapper div input')

		for(let i=0; i<elems.length; i++) {

			if($(elems[i]).is(':focus') && $(elems[i]).val().trim() != '') {

				if(typeof elems[i + 1] != 'undefined')
					$(elems[i + 1]).focus();
				else
					app.submit();

				break;
			}

		}

	}

	app.submit = function() {

		const amount = $('#app-bank-transfer-menu input[name="transfer-amount"]').val();
		const phoneNumber = $('#app-bank-transfer-menu input[name="transfer-receiver"]').val();

		$.post('http://esx_phone3/send_swish', JSON.stringify({
			["phoneNumber"]: phoneNumber,
			["amount"]: amount
		}));

		Phone.close();
	}

})();