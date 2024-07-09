<template>
    <div>
      <h2 class="text-center mb-4 hkf_title">Add Account Head</h2>
 <div class="input-group col-md-6 page_to_page">
     <router-link :to="{ name: 'account_head' }" class="btn btn-primary"
      >All Account</router-link
    >
   </div>
  <div class="row">
    <div class="col-md-6 ">

      <form class="form" @submit.prevent='addAccountHead()'>
        <div class="form-group mx-sm-3 mb-2">
          <label  class="hkf_text">Account Head</label>
          <input
            type="text"
            class="form-control"

            placeholder="Account Head"
            v-model='form.account_head'
            required
          />
        </div>
         <div class="form-group mx-sm-3 mb-2">
          <label  class="hkf_text">Account Code</label>
          <input
            type="text"
            class="form-control"

            placeholder="Account Code"
            v-model='form.account_code'
            required
          />
        </div>

        <div class="form-group mx-sm-3 mb-2">
          <label class="hkf_text">Account Type</label>
         <select class="form-control" id="status" name="status" v-model='form.type_name' required>
          <option v-for="(option, index) in account_types" :key="index" :value='option.type_name'>{{ option.type_name }}</option>
          </select>

        </div>

        <button type="submit" class="btn btn-primary mb-2">Save</button>
      </form>
        <small class="text text-danger" v-if='errors.type_name'>{{errors.type_name[0]}}</small>

    </div>
  </div>
  </div>
</template>
<script>
export default {
    name:'add_account_type',
    beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else if (User.getGuard() == "manager") {
        vm.$router.push({ name: "manager_dashboard" });
      } else {
        vm.$router.push({ name: "add_account_head" });
      }
    });
  },
  data(){
    return{
        form:{
            account_head:'',
            account_code:'',
            opening_balance:0,
            type_name:'',
        },

        account_types:[],
          errors:{

      },

    }
  },
    created(){
    axios.get('/api/account_type/').then((res)=>{
        this.account_types = res.data;
       console.log(this.account_types);
    }).catch((err)=>{
        console.log(err.response);
    });
    },
  methods:{
        addAccountHead(){
            axios.post('/api/account_head',this.form).then(
              (res)=>
              {
                console.log(res.data);
                this.$router.push({name:'account_head'});
              }
            ).catch((error) =>{
              this.errors = JSON.parse(error.response.data);
            });


        },

},
computed:{

}

}
</script>
