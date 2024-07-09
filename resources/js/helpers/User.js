import Token from './Token';
import AppStorage from './AppStorage';

class User{
    responseAfterLogin(res){
        const token = res.data.token;
        const user = res.data.username;
        const guard = res.data.guard;
        if(Token.isValid(token)){
            AppStorage.store(token,user,guard);
        }

    }

    responseAfterRegister(res){
        console.log(res);
        const token = res.data.token;
        const user = res.data.username;
        const guard = res.data.guard;
        if(Token.isValid(token)){
             AppStorage.store(token,user,guard);

        }
    }
    hasToken(){
        const storeToken = localStorage.getItem('token');
        if(storeToken){
            return Token.isValid(storeToken) ? true : false
        }
        return false;
    }
    hasLoggedIn(){
        return this.hasToken();
    }
    name(){
        if(this.hasLoggedIn()){
            return localStorage.getItem('username');
        }

    }
    id(){
        if(this.hasLoggedIn()){
            const payload = Token.isValid(localStorage.getItem('token'));
            return payload.sub;
        }
        return false;
    }
    logout(){
        AppStorage.clear();
    }
    getGuard(){
        if(this.hasLoggedIn()){
            return localStorage.getItem('guard');
        }
    }
    getUserName(){
        if(this.hasLoggedIn){
            return localStorage.getItem('user');
        }
    }


}
export default User = new User();
