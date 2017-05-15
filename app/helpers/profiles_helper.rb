module ProfilesHelper
 def upuser
 	randombot = rand(1...1000000000)
 
    if current_user.balance > 50
      a = current_user
      a.refferences.new(name: "Donate#{randombot}", email: "Donate#{randombot}@m.r", password: 'yk,Y@&7v`-8n-C3c', reffered_by: current_user.id)
      a.save

    else
      flash[:balancenot] = "Не достаточно баланса"
    end   
  end
end
