<template>
  <div class="row">
    <div class="col-md-12 mx-auto">
      <div class="row">
        <div class="col-md-10 mx-auto">
          <button
            type="button"
            class="btn action_print"
            style="margin-left: 85%"
            @click="printContent"
          >
            Print<i class="fa fa-print pl-2" aria-hidden="true"></i>
          </button>

          <form>
            <div id="print-container">
            <div style="display: flex; border-bottom: 1px solid black" class="mb-3">
              <div class="sidebar-brand-icon" style="text-align: left; width: 20%">
                <img
                  class="logo"
                  :src="'../img/' + avatar"
                  style="width: 165%; height: 77%"
                  alt=""
                />
              </div>
              <div style="padding: 5%; width: 80%">
                <h3 style="text-align: center">HKF Real Estate LTD</h3>
                <h4 style="text-align: center">
                  117/2/8 1st Floor Sopnodanga Residential Area<br />
                  Phone: 01400407270 <br />
                  Email:contact@hkf-re.com <br />
                  Website: www.hkf-re.com
                </h4>
              </div>
            </div>


            <h3 style="text-align: center">Stock Transfer</h3>

            <h5 style="text-align: right">Date: {{ form.basic_date }}</h5>
            <table
              style="
                width: 100%;
                border: 1px solid black;
                border-collapse: collapse;
                margin-bottom: 1.5rem;
              "
            >
              <tr
                style="
                  padding: 1.5rem;
                  border: 1px solid black;
                  border-collapse: collapse;
                "
              >
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;

                  "
                >
                  Product Name: {{ form.product_name }}
                </td>


                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;

                  "
                >
                  Transfer Quantity:<span style="margin-left: 1rem">{{ form.quanity }}</span>
                </td>
              </tr>
              <tr style="border: 1px solid black; border-collapse: collapse">
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;

                  "
                >
                  Transfer From Project : {{ form.fromProject }}


                </td>


                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;

                  "
                >
                 Transfer From Building:<span style="margin-left: 1rem">{{
                    form.fromBuilding
                  }}</span>
                </td>
              </tr>
              <tr style="border: 1px solid black; border-collapse: collapse">
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;

                  "
                >
                 Transfer To Project : {{ form.selectedProject }}


                </td>


                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;

                  "
                >
                  Transfer To Building:<span style="margin-left: 1rem">{{
                    form.selectedBuilding
                  }}</span>
                </td>
              </tr>
              <tr style="border: 1px solid black; border-collapse: collapse">
                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;

                  "
                >
                  Purpose :  {{ form.purpose }}
                </td>


                <td
                  style="
                    padding: 1.5rem;
                    border: 1px solid black;
                    text-align: center;

                  "
                >
                  Note:<span style="margin-left: 1rem">{{ form.note }}</span>
                </td>
              </tr>
            </table>


          </div>
           <h5>Document:</h5>
          <button
            type="button"
            class="btn action mt-2"
            @click="PrintContent5"
            style="width: 100px"
            v-if="form.Supporting_docs != ''"
          >
            Print <i class="fa fa-print pl-2" aria-hidden="true"></i>
          </button>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "all_project",
  data() {
    return {
         avatar: "logo.png",
       form: {
        product_name: "",
        selectedProject: "",
        quantity: "",
        note: "",
        purpose:"",
        selectedBuilding: "",
        fromProject:"",
        fromBuilding:"",
        Supporting_docs:"",
        unit:"",
        basic_date:"",
      },
    };
  },

  methods: {
    fetchProjects(){
        axios.get('/api/stock_transfer/'+this.$route.params.id).then((res)=>{
            this.form= res.data;
        }).catch((err)=>{
            console.log(err.response);
        })
    },
     printContent() {
      const printContents = document.getElementById("print-container").innerHTML;
      const originalContents = document.body.innerHTML;
      const popupWin = window.open("width=800,height=800");
      popupWin.document.open();
      popupWin.document.write(`
        <html>
          <head>
            <style>
              /* Your styles go here */
              *{
                padding:0.25rem;
              }

            </style>
          </head>
          <body onload="window.print();window.close();">${printContents}</body>
        </html>
      `);
      popupWin.document.close();
      this.$router.push({ name: "view_stock_transfer-", params: { id: this.$route.params.id } });
    },
    PrintContent5() {
      const file = "../" + this.form.Supporting_docs;
      const newWindow = window.open(file);
      newWindow.onload = () => {
        newWindow.print();
        newWindlow.close();
        if (newWindlow.close()) {
          this.$router.push({
            name: "view_stock_transfer",
            params: { id: this.$route.params.id },
          });
        }
      };
    },

  },
  created() {
    this.fetchProjects();
  },

  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else {
        vm.$router.push({ name: "view_stock_transfer" });
      }
    });
  },
};
</script>
<style>
.hkf_text {
  color: #4e3089 !important;
}
th {
  font-weight: bold;
  color: #473b5edb;
}
table tr:nth-child(even) {
  background-color: #605ca8 !important;
  color: white;
}
.action {
  color: white;
  background: #5d57c3;
  padding: 5px;
  width: 60px;
}
table tr:nth-child(odd) {
  color: #473b5edb;
  font-weight: bold;
}
.status_project {
  font-weight: bold;
  font-size: 1.2rem;
}
.text-warning {
  color: #35354c !important;
}
.text-info {
  color: #36becc !important;
}
.text-success {
  color: #63cb49 !important;
}
.page_to_page {
  margin-bottom: 1rem;
}
table tr:nth-child(even) .remove_bg_td {
  background: white;
}
.pagination {
  display: flex;
  justify-content: center;
  margin-top: 20px;
}

.pagination li {
  list-style: none;
  margin: 0 5px;
  display: inline;
}

.pagination li.active a {
  color: #ffffff;
  background-color: #007bff;
  border: 1px solid #007bff;
}

.pagination li a {
  color: #007bff;
  background-color: #ffffff;
  border: 1px solid #007bff;
  padding: 6px 12px;
  text-decoration: none;
  cursor: pointer;
  margin-right: 5px;
}
.pagination li a :hover {
  background-color: #007bff;
  color: #ffffff;
}
</style>
