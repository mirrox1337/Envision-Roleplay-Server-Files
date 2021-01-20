(function(){

	Phone.apps['bank'] = {};
	const app = Phone.apps['bank'];
	let currentRow = 0;
	const elems = [];

	$('#app-bank .button').each((i,e) => elems.push(e));

	elems.reverse();

	app.open = function(data) {

		$('.status-bar').css("background-color", "");
		$('.status-bar').css("color", "");

		if(elems.length > 0)
			app.selectElem(elems[0]);

	}

	app.move = function(direction) {

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

		app.selectElem(elems[currentRow]);

	}

	app.enter = function() {

		Phone.open('bank-transfer-menu'); 

	}

	app.selectElem = function(elem) {

		currentAction = $(elem).data('action');

		for(let i=0; i<elems.length; i++)
			$(elems[i]).removeClass('selected animated pulse infinite');

		$(elem).addClass('selected animated pulse infinite');
	}

})();