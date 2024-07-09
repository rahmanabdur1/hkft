class Token{
    isValid(token){
        const payload = this.payload(token);
        if(payload){
            return payload.iss = 'https://hkferp.com/api/admin/login' || 'https://hkferp.com/api/admin/register' || 'https://hkferp.com/api/manager/login' || 'https://hkferp.com/api/manager/register' ? true : false;
        }
        return 'not valid token';
    }
    payload(token){
       const payload = token.split('.')[1];
       return this.decode(payload);
    }

    decode(token){
        return JSON.parse(atob(token));
    }
}

export default Token = new Token();
