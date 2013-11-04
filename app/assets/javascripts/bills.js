$(function() {

	$("#add-bill").click(function(e) {
		e.preventDefault();
		if ($("#bill-name").val() == "") {
			alert("Name of bill cannot be blank.");
		} else {
			submitBill();
		}
	});

	$(".tooltip-info").click(function(e) {
		e.preventDefault();
	});

	var numFriends = 1;

	$("#split-evenly").click(function(e) {
		e.preventDefault();
		splitEvenly();
	});

	$("#split-exact-amounts").click(function(e) {
		e.preventDefault();
		splitExactAmounts();
	});

	var splitEvenly = function() {
		$("#guests-on-bill").html(JST['bills/splitevenly']({}));

		$(".add-friend").click(function(e) {
			e.preventDefault();
			numFriends += 1;
			addFriendTextBox("split evenly");
		});
	};

	var splitExactAmounts = function() {
		$("#guests-on-bill").html(JST['bills/split_exact_amounts']({}));

		$(".add-friend").click(function(e) {
			e.preventDefault();
			numFriends += 1;
			addFriendTextBox("split exact amounts");
		});
	};

	var addFriendTextBox = function(howToSplit) {
		if (howToSplit == "split evenly") {
			var $textBox = $('<div><input type="text" class="friend-name" name="bill[guests][][name]" data-id=' + numFriends + ' placeholder="Enter Friend Name"> paid <input type="number" class="friend-paid" name="bill[guests][][amount_paid]" data-id=' + numFriends + ' placeholder="Amount"></div><br>');
		} else {
			var $textBox = $('<div><input type="text" class="friend-name" name="bill[guests][][name]" data-id=' + numFriends + ' placeholder="Enter Friend Name"> paid <input type="number" class="friend-paid" data-id=' + numFriends + ' placeholder="Amount"></div><br>');
		}
		var $removeTextBoxButton = $('<button class="btn btn-warning remove-friend" data-id=' + numFriends + '>Remove This Friend</button>');
		$textBox.append($removeTextBoxButton);
		$(".add-friend").before($textBox);

		$(".remove-friend").click(function(e) {
			e.preventDefault();
			var friendNum = $(this).data("id");
			$('[data-id=' + friendNum + ']').remove();
		});
	};

	var submitBill = function() {
		var bill = $.post("/bills.json", {bill: {name: 'abc', amount: 10} });
		bill.done(function(data) {
			$("#form-submit-messages").text(data.message);
		});
	};

	var getNamesAndAmounts = function() {
		console.log("get names and amounts");
	};
});
