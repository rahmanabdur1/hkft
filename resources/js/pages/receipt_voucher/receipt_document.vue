<template>
  <div>
    <button type="button" class="btn action" @click="PrintContent3" style='width:100px'>Print <i class="fa fa-print pl-2" aria-hidden="true"></i
              ></button>
    <div id="print-container3" class="mt-5">
      <div class='row'>
            <div class='col-md-12'>
                <embed :src="'../' + form.Supporting_docs" class='print_img' style='width:800px;height:600px;'/>
            </div>

      </div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {

      form: {
        Supporting_docs: "",
      },
    };
  },
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else if (User.getGuard() == "manager") {
          axios.get("/api/fetch_access/" + User.getUserName()).then((res) => {
          if (User.getUserName() != res.data.manager_name) {
            vm.$router.push({ name: "manager_dashboard" });
          }
        });
      } else {
        vm.$router.push({ name: "receipt_document" });
      }
    });
  },
  created() {

    let id = this.$route.params.id;
    axios
      .get("/api/receipt_voucher/" + id)
      .then(({ data }) => {
        this.form.Supporting_docs = data.Supporting_docs;

      })
      .catch((err) => {
      });

  },
  methods: {
    PrintContent3() {
      setTimeout(() => {
        const printContents3 = document.getElementById("print-container3").innerHTML;
      const originalContents3 = document.body.innerHTML;
      const popupWin3 = window.open("width=800,height=800");
      popupWin3.document.open();
      popupWin3.document.write(`
        <html>
          <head>
            <style>
              /* Your styles go here */
              *{
                padding:0.45em;
              }
            .print_img{
                width:100%;
                height:auto;
            }
            </style>
          </head>
          <body onload="window.print();window.close();">${printContents3}</body>
        </html>
      `);
      popupWin3.document.close();
      document.body.innerHTML = originalContents3;
      }, 3000);
    },
  },
};
</script>
<style >
    #print-container3 img{
        width:80%;
        height:auto;
    }
</style>
