module ContactsHelper

	def generate_list_of_group_members(allcontacts, groupname)
		groupmemebers = []
		allcontacts.each do |contact|
			if contact.group_name == groupname
				groupmemebers.push(contact.email)
			end
		end
		groupmemebers
	end

	def generate_list_of_all_members(allcontacts)
		contact_list = []
		allcontacts.each do |contact|
			if contact.group_name == "default"
				contact_list.push(contact)
			end
		end
		contact_list
	end

	def generate_non_group_member_list(allcontacts, groupname)
		group_members_list = generate_list_of_group_members(allcontacts, groupname)
		all_contacts_list = generate_list_of_all_members(allcontacts)
		non_member_list = []
		all_contacts_list.each do |contact|
			if !group_members_list.include?(contact.email)
				non_member_list.push(contact)
			end
		end
		non_member_list
	end

end
