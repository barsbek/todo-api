json.(@user, :id, :name, :email)
json.token @user.encode_token
