<template>
    <div>
      <h2 class="text-center mb-4 hkf_title">Add Account Type</h2>
 <div class="input-group col-md-6 page_to_page">
     <router-link :to="{ name: 'account_type' }" class="btn btn-primary"
      >All Account</router-link
    >
   </div>
  <div class="row">
    <div class="col-md-12 mx-auto">
      
      <form class="form-inline" @submit.prevent='addAccountType()'>
        <div class="form-group mx-sm-3 mb-2">
          <label for="projectName" class="hkf_text">Type Name</label>
          <input
            type="text"
            class="form-control"
            
            placeholder="Account Type Name"
            v-model='form.type_name'
            required
          />
        </div>
        
        <div class="form-group mx-sm-3 mb-2">
          <label class="hkf_text">Status</label>
          <select class="form-control" id="status" name="status" v-model='form.type_status' required>
          <option v-for="(option, index) in options" :key="index" :value="option.value">{{ option.label }}</option>
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
        vm.$router.push({ name: "add_account_type" });
      }
    });
  },
  data(){
    return{
        form:{
            type_name:'',
            type_status:'',
        },
        options: [
        { value: 'active', label: 'active' },
        { value: 'inactive', label: 'inactive' },
      ],
      errors:{

      },
    }
  },
  methods:{
        addAccountType(){
            axios.post('/api/account_type',this.form).then(
              (res)=>
              {
                console.log(res.data);
                this.$router.push({name:'account_type'});
              }
            ).catch((error) =>{
              this.errors = JSON.parse(error.response.data);
            });
            
        }
}
}
</script>