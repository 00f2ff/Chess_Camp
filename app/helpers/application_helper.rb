module ApplicationHelper

	# calculate family payments for family report
	def family_payments(cost, status)
		status == 'full' ? "$0" : "$#{cost-50}"
	end

	# calculate total payments for year report
	def total_payments(size, cost, status)
		status == 'full' ? "$#{size*cost}" : "$#{size*cost-50}"
	end

	# for use in camp registration form
	def students_eligible_for_camp(camp)
		# all rating-eligible students - those already registered
		eligible = Student.active.below_rating(camp.curriculum.max_rating+1).at_or_above_rating(camp.curriculum.min_rating) - camp.students 
		return eligible
	end

end