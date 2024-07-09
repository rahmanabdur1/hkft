<template>
  <div class="row">
    <div class="col-md-12">
      <div class="header">
        <h2 class="text-center mb-4 hkf_title">Edit Account Head</h2>
      </div>
      <div class="float-right" style="margin: 10px 40px 15px 0px">
        <router-link :to="{ name: 'account_head' }" class="btn btn-primary"
          >Account Head </router-link
        >
      </div>
      <div class="col-md-8">
        <form @submit.prevent="updateProject()">
         
          <div class="form-row">
            <div class="form-group col-md-6">
              <label for="inputEmail4" class="hkf_texts">Account Code </label>
              <input type="text" class="form-control" v-model="form.account_code" />
              <small class="text text-danger" v-if="errors.account_code">{{
                errors.account_code[0]
              }}</small>
            </div>

       
            <div class="form-group col-md-6">
              <label for="inputEmail4" class="hkf_texts">Account Head </label>
              <input type="text" class="form-control" v-model="form.account_head" />
              <small class="text text-danger" v-if="errors.account_head">{{
                errors.account_head[0]
              }}</small>
            </div>
            
            <div class="form-group col-md-6">
              <label for="inputEmail4" class="hkf_texts"> Balance </label>
              <input type="text" class="form-control" v-model="form.opening_balance" />
              <small class="text text-danger" v-if="errors.opening_balance">{{
                errors.opening_balance[0]
              }}</small>
            </div>
            <div class="form-group col-md-6">
              <label class="hkf_texts">Account Type</label>
              <select
                class="form-control"
                id="status"
                name="status"
                v-model="form.type_name"
                required
              >
                <option
                  v-for="(option, index) in accounts"
                  :key="index"
                  :value="option.type_name"
                >
                  {{ option.type_name }}
                </option>
              </select>
              <small class="text text-danger" v-if="errors.type_status">{{
                errors.type_status[0]
              }}</small>
            </div>
          </div>
          <button type="submit" class="btn btn-primary">Submit</button>
        </form>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "edit_account_head",
  data() {
    return {
      accounts:[],
      form: {
        account_head:"",
        account_code:"",
        opening_balance:"",
        type_name: "",
      },
    
      errors: {},
    };
  },
  created() {
    
    let id = this.$route.params.id;
    axios.get('/api/account_head/'+id).then((res)=>{
      this.form = res.data;
    }).catch((err)=>{
      console.log(err.response);
    });
    axios.get('/api/account_type').then((res)=>{
        this.accounts = res.data;
    }).catch((err)=>{
        console.log(err.response);
    })
  },
  methods:{
    updateProject(){
       let id=this.$route.params.id;
       axios.patch('/api/account_head/'+id,this.form).then(res=>{
        this.$router.push({name:'account_head'});
       }).catch((err)=>{
        this.errors = err.response.data;
        console.log(this.errors);
       });
    }
  },
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else if (User.getGuard() == "manager") {
        vm.$router.push({ name: "manager_dashboard" });
      } else {
        vm.$router.push({ name: "edit_account_head" });
      }
    });
  },
};
</script>

<style >
.hkf_title {
  color: #605ca8 !important;
  border-bottom: 1px solid #554e6a;
}
.hkf_texts{
  color: #605ca8 !important;
  font-weight:bold;
}
</style>
