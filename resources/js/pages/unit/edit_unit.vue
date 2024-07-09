<template>
  <div class="row">
    <div class="col-md-12">
      <div class="header">
        <h2 class="text-center mb-4 hkf_title">Edit Unit</h2>
      </div>

      <div class="col-md-8">
        <form @submit.prevent="updateUnit()">
 <div class="form-row">
            <div class="form-group col-md-6">
              <label for="inputEmail4" class="hkf_texts">Unit Name</label>
              <input type="text" class="form-control" v-model="form.item_name" />
              <small class="text text-danger" v-if="errors.item_name">{{
                errors.item_name[0]
              }}</small>
            </div>


            <div class="form-group col-md-6">
              <label class="hkf_texts">Status</label>
              <input type="text" class="form-control" v-model="form.item_unit" />
              <small class="text text-danger" v-if="errors.item_unit">{{
                errors.item_unit[0]
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
  name: "edit_unit",
  data() {
    return {

      form: {
        item_name: "",
        item_unit: "",

      },

      errors: {},
    };
  },
  created() {

    let id = this.$route.params.id;
    axios.get('/api/unit/'+id).then((res)=>{
      this.form = res.data;
    }).catch((err)=>{
      console.log(err.response);
    })
  },
  methods:{
    updateUnit(){
       let id=this.$route.params.id;
       axios.patch('/api/unit/'+id,this.form,
 {
                  headers: {
                   "Content-Type": "application/json",
                    "Accept": "application/json",
                  },
                }).then(res=>{
        this.$router.push({name:'all_unit'});
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
        vm.$router.push({ name: "edit_unit" });
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
