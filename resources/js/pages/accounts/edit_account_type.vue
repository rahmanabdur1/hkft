<template>
  <div class="row">
    <div class="col-md-12">
      <div class="header">
        <h2 class="text-center mb-4 hkf_title">Edit Account Type</h2>
      </div>
      
      <div class="col-md-8">
        <form @submit.prevent="updateAccountHead()">
 <div class="form-row">
            <div class="form-group col-md-6">
              <label for="inputEmail4" class="hkf_texts">Account Type Name</label>
              <input type="text" class="form-control" v-model="form.type_name" />
              <small class="text text-danger" v-if="errors.type_name">{{
                errors.type_name[0]
              }}</small>
            </div>

        
            <div class="form-group col-md-6">
              <label class="hkf_texts">Status</label>
              <select
                class="form-control"
                id="status"
                name="status"
                v-model="form.type_status"
                required
              >
                <option
                  v-for="(option, index) in options"
                  :key="index"
                  :value="option.value"
                >
                  {{ option.label }}
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
  name: "edit_project",
  data() {
    return {
      account_types:[],
      form: {
        account_code: "",
        account_head: "",
        opening_balance:"",
        type_name:"",
      },
      options: [
        { value: 'active', label: 'active' },
        { value: 'inactive', label: 'inactive' },
      ],
      errors: {},
    };
  },
  created() {
    
    let id = this.$route.params.id;
    axios.get('/api/account_type/'+id).then((res)=>{
      this.form = res.data;
    }).catch((err)=>{
      console.log(err.response);
    })
  },
  methods:{
    updateAccountHead(){
       let id=this.$route.params.id;
       axios.patch('/api/account_type/'+id,this.form).then(res=>{
        this.$router.push({name:'account_type'});
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
        vm.$router.push({ name: "edit_account_type" });
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
