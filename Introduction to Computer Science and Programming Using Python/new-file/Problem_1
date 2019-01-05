n=12
def remaining_balance (balance,n):
	if (n>0):
		monthlyInterestRate=annualInterestRate/12
		minimumMonthlyPayment=monthlyPaymentRate*balance
		monthlyUnpaidBalance=balance-minimumMonthlyPayment
		balance=monthlyUnpaidBalance+monthlyInterestRate*monthlyUnpaidBalance
		return remaining_balance(balance,n-1)
	else:
		return str(round(balance,2))
print("Remaining balance: "+ remaining_balance(balance,12))
