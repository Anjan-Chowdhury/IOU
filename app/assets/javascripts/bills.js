$(function() {
	var numFriends = 1;

	$(".tooltip-info").click(function(e) {
		e.preventDefault();
	});

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

		$("#new-bill-form").submit(function(e) {
			$(".form-errors").empty(); 
			if (checkForInvalidFormInput() == true) {
				e.preventDefault();
			}
		});
	};

	var splitExactAmounts = function() {
		$("#guests-on-bill").html(JST['bills/split_exact_amounts']({}));

		$(".add-friend").click(function(e) {
			e.preventDefault();
			numFriends += 1;
			addFriendTextBox("split exact amounts");
		});

		$("#new-bill-form").submit(function(e) {
			$(".form-errors").empty(); 
			if (checkForInvalidFormInput() == true) {
				e.preventDefault();
			}
		});
	};

	var addFriendTextBox = function(howToSplit) {
		if (howToSplit == "split evenly") {
			var $textBox = JST['bills/add_friend_split_evenly']({ numFriends: numFriends });
		} else {
			var $textBox = JST['bills/add_friend_split_exact_amounts']({ numFriends: numFriends});
		}

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

	var checkForInvalidFormInput = function() {
		var totalPaidByGuests = 0;
		var totalShouldHavePaidByGuests = 0;
		var invalidInput = false;
		var numMissingGuestNames = 0;

		if ($("#bill-name").val() == "") {
			$("#bill-name-errors").append("Bill Name cannot be blank.");
			invalidInput = true;
		}

		if ($("#bill-amount").val() == "") {
			$("#bill-amount-errors").append("Bill Amount cannot be blank.");
			invalidInput = true;
		}

		$.each($(".amount-paid"), function() {
			totalPaidByGuests += parseInt($(this).val());
		});

		if (totalPaidByGuests != $("#bill-amount").val()) {
			$("#form-submit-messages").append("Please check that amounts guests paid matches bill total.<br>");
			invalidInput = true;
		}

		$.each($(".amount-should-have-paid"), function() {
			totalShouldHavePaidByGuests += parseInt($(this).val());
		});

		if (totalShouldHavePaidByGuests != $("#bill-amount").val()) {
			$("#form-submit-messages").append("Please check that amounts guests should have paid matches bill total.<br>");
			invalidInput = true;
		}

		$.each($(".guest-name"), function() {
			if ($(this).val() == "") {
				numMissingGuestNames += 1;
			}
		});

		if (numMissingGuestNames > 0) {
			$("#form-submit-messages").append("Friend names cannot be blank.");
			invalidInput = true;
		}

		return invalidInput;
	};
});
