class AppStorage {
    storeToken(token){
        localStorage.setItem('token',token);
    }

    storeUser(user){
        localStorage.setItem('user',user);
    }
    storeGuard(guard){
        localStorage.setItem('guard',guard);
    }
    store(token,user,guard){
        this.storeToken(token);
        this.storeUser(user);
        this.storeGuard(guard);
    }

    getToken(){
        localStorage.getItem('token');
    }
    getUser(){
        localStorage.getItem('user');
    }
 
    clear(){
        localStorage.removeItem('token');
        localStorage.removeItem('user');
        localStorage.removeItem('guard');
    }
}
export default AppStorage = new AppStorage();