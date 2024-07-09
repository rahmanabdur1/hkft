<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">
      View Reference: {{ reference.reference_name }}
    </h2>
    <div class="input-group col-md-6 page_to_page">
      <router-link :to="{ name: 'all_reference' }" class="btn btn-primary"
        >All Reference</router-link
      >
    </div>
    <div class="row">
      <div class="col-md-12 mx-auto">
        <table class="table table-striped">
          <thead>
            <tr>
              <th>Date</th>
              <th>Client Name</th>
              <th>Property Name</th>
              <th>Receipt Voucher No</th>
              <th>Amount</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(form, index) in forms" :key='index'>
              <td>{{ form.date }}</td>
              <td>{{ form.client_name }}</td>
              <td>{{ form.product_name }}</td>
              <td>{{ form.voucher_no }}</td>
              <td>{{ form.reference_amount }}tk</td>
              <td>
                <button class="btn" @click="deleteReference(form.id)">
                  <i class="fa fa-trash"></i>
                </button>
              </td>
            </tr>

            <!-- Add more rows here if needed -->
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "view_reference",
  data() {
    return {
      logo: "",
      reference_form: {
        reference_name: "",
        reference_id: "",
        product_name: "",
        date: "",
        reference_amount: "",
        client_name: "",
        voucher_no: "",
      },
      reference: {
        reference_name: "",
        reference_id: "",
      },
      forms: [],
    };
  },
  created() {
    let id = this.$route.params.id;
    axios
      .get("/api/reference_info/" + id)
      .then(({ data }) => {
        this.reference = data;
        axios
          .post("/api/reference_clients", this.reference, {
                  headers: {
                   "Content-Type": "application/json",
                    "Accept": "application/json",
                  },
                })
          .then((res) => {
            this.forms = res.data;
          })
          .catch((err) => {
            console.log(err.response);
          });
      })
      .catch((err) => {
        console.log(err.response);
      });
  },
  methods: {
    deleteReference(id) {
Swal.fire({
  title: 'Are you sure?',
  text: "You won't be able to revert this!",
  icon: 'warning',
  showCancelButton: true,
  confirmButtonColor: '#3085d6',
  cancelButtonColor: '#d33',
  confirmButtonText: 'Yes, delete it!'
}).then((result) => {
  if (result.isConfirmed) {
     axios.delete('/api/reference/'+id).then((res)=>{
        this.forms = this.forms.filter((item)=>{
            return item.id !=id;
        })
      }).catch((err)=>{
          console.log(err.response);
      });

    Swal.fire(
      'Deleted!',
      'Your file has been deleted.',
      'success'
    )
  }
})




//

    },
  },
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      }else if (User.getGuard() == "manager") {
         vm.$router.push({ name: "manager_dashboard" });
      }  else {
        vm.$router.push({ name: "view_reference" });
      }
    });
  },
};
</script>

<style>
.hkf_title {
  color: #605ca8 !important;
  border-bottom: 1px solid #554e6a;
}
.hkf_texts {
  color: #605ca8 !important;
  font-weight: bold;
}
</style>
