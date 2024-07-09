<template>
  <div>
    <h2 class="text-center mb-4 hkf_title">Accounts Payable</h2>

    <div class="row">
      <div class="col-md-12" style="display: flex">
        <div class="col-md-5 mt-4">
          <button
            type=" button"
            @click="showAll"
            class="action btn mx-auto mb-5"
            style="width: 80%; padding: 0.5rem"
          >
            Show All Accounts Payable
          </button>
        </div>
        <div class="form-group col-md-3 mx-sm-3 mb-2" v-if="isAdmin">
          <label for="projectName" class="hkf_text">Select Project</label>
          <select
            class="form-control status"
            id="status"
            v-model="selectedProject"
            onfocus="this.size=10"
            onblur="this.size=1"
            onchange="this.size=1;this.blur();"
            @change="chooseProject"
            required
          >
            <option
              v-for="(project, index) in projects"
              :key="index"
              :value="project.project"
            >
              {{ project.project }}
            </option>
          </select>
        </div>
        <div class="form-group col-md-3 mx-sm-3 mb-2" v-if="isManager">
          <label for="projectName" class="hkf_text">Select Project</label>
          <select
            class="form-control status"
            id="status"
            v-model="selectedProject"
            onfocus="this.size=10"
            onblur="this.size=1"
            onchange="this.size=1;this.blur();"
            @change="chooseProject"
            required
          >
            <option
              v-for="(project, index) in projects"
              :key="index"
              :value="project.project"
            >
              {{ project.project }}
            </option>
          </select>
        </div>
        <div class="form-group col-md-3 mx-sm-3 mb-2" v-if="isBuilding">
          <label for="projectName" class="hkf_text">Select Building</label>
          <select
            class="form-control status"
            id="status"
            v-model="selectedBuilding"
            onfocus="this.size=10"
            onblur="this.size=1"
            onchange="this.size=1;this.blur();"
            @change="chooseBuilding"
            required
          >
            <option
              v-for="(project, index) in buildings"
              :key="index"
              :value="project.building_name"
            >
              {{ project.building_name }}
            </option>
          </select>
        </div>
      </div>

      <form @submit.prevent="dateAccounts" class="col-md-12">
        <div class="row">
          <div class="form-group col-md-5">
            <label for="" class="hkf_text">Start Date</label>
            <input
              type="date"
              v-model="okStartDate"
              class="form-control rounded"
              aria-label="Search"
              aria-describedby="search-addon"
              required
            />
          </div>
          <div class="form-group col-md-5">
            <label for="" class="hkf_text">End Date</label>
            <input
              type="date"
              v-model="okEndDate"
              class="form-control rounded"
              aria-label="Search"
              aria-describedby="search-addon"
              required
            />
          </div>
          <div class="form-group col-md-2" style="margin-top: 30px">
            <button type="submit" class="btn btn-primary" style="height: 38px">
              Search
            </button>
          </div>
        </div>
      </form>
      <table style="width: 100%; margin-bottom: 1rem">
        <tbdoy v-for="(purchased_journal, index) in purchased_journals" :key="index">
          <div style="display: flex" class="mb-2">
            <div class="col-md-6">
              <h6 class="hkf_text" style="list-style: square">{{ index + 1 }}</h6>
            </div>
            <div class="col-md-6 text-right">
              <button
                type="button"
                class="action btn"
                @click="getUrlID(purchased_journal.payment_id)"
              >
                View
              </button>
            </div>
          </div>
          <tr style="border: 1px solid black; border-collapse: collapse">
            <th
              style="
                padding: 1rem;
                border: 1px solid black;
                text-align: center;
                width: 4%;
                color: white;
              "
            >
              Sl
            </th>
            <th
              style="
                padding: 1rem;
                border: 1px solid black;
                text-align: center;
                width: 24%;
                color: white;
              "
            >
              Particular
            </th>
            <th
              style="
                padding: 1rem;
                border: 1px solid black;
                text-align: center;
                width: 24%;
                color: white;
              "
            >
              Cost Center
            </th>
            <th
              style="
                padding: 1rem;
                border: 1px solid black;
                text-align: center;
                width: 24%;
                color: white;
              "
            >
              Debit
            </th>
            <th
              style="
                padding: 1rem;
                border: 1px solid black;
                text-align: center;
                width: 24%;
                color: white;
              "
            >
              Credit
            </th>
          </tr>

          <tr style="padding: 1rem; border: 1px solid black; border-collapse: collapse">
            <td
              style="
                padding: 1rem;
                border: 1px solid black;
                text-align: center;
                width: 4%;
              "
            >
              1
            </td>
            <td
              style="
                padding: 1rem;
                border: 1px solid black;
                text-align: center;
                width: 24%;
              "
            >
              {{ purchased_journal.product_name }} Purchase
            </td>
            <td
              style="
                padding: 1rem;
                border: 1px solid black;
                text-align: center;
                width: 24%;
              "
            >
              {{ purchased_journal.project }}
            </td>
            <td
              style="
                padding: 1rem;
                border: 1px solid black;
                text-align: center;
                width: 24%;
              "
            >
              {{ parseFloat(purchased_journal.due).toFixed(2) }}
            </td>
            <td
              style="
                padding: 1rem;
                border: 1px solid black;
                text-align: center;
                width: 24%;
              "
            >
              {{ parseFloat(0).toFixed(2) }}
            </td>
          </tr>
          <tr style="padding: 1rem; border: 1px solid black; border-collapse: collapse">
            <td
              style="
                padding: 1rem;
                border: 1px solid black;
                text-align: center;
                width: 4%;
              "
            >
              2
            </td>

            <td
              style="
                padding: 1rem;
                border: 1px solid black;
                text-align: center;
                width: 24%;
              "
            >
              {{ purchased_journal.payee_name }}
            </td>
            <td
              style="
                padding: 1rem;
                border: 1px solid black;
                text-align: center;
                width: 24%;
              "
            >
              {{ purchased_journal.project }}
            </td>
            <td
              style="
                padding: 1rem;
                border: 1px solid black;
                text-align: center;
                width: 24%;
              "
            >
              {{ parseFloat(0).toFixed(2) }}
            </td>
            <td
              style="
                padding: 1rem;
                border: 1px solid black;
                text-align: center;
                width: 24%;
              "
            >
              {{ parseFloat(purchased_journal.due).toFixed(2) }}
            </td>
          </tr>
          <tr style="padding: 1rem; border: 1px solid black; border-collapse: collapse">
            <td
              style="
                padding: 1rem;

                text-align: center;
                width: 4%;
              "
            ></td>
            <td
              style="
                padding: 1rem;

                text-align: center;
                width: 24%;
              "
            >
              Total
            </td>
            <td
              style="
                padding: 1rem;

                text-align: center;
                width: 24%;
              "
            ></td>
            <td
              style="
                padding: 1rem;
                border: 1px solid black;
                text-align: center;
                width: 24%;
              "
            >
              {{ parseFloat(purchased_journal.due).toFixed(2) }}
            </td>
            <td
              style="
                padding: 1rem;
                border: 1px solid black;
                text-align: center;
                width: 24%;
              "
            >
              {{ parseFloat(purchased_journal.due).toFixed(2) }}
            </td>
          </tr>
          <hr />
        </tbdoy>
      </table>
      <div style="width: 100%; text-align: center">
        <h3 v-if="empty" style="color: red">{{ this.msg }}</h3>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: "purchase_journal",
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      // Access the $router property here
      if (!User.hasLoggedIn()) {
        vm.$router.push({ name: "home" });
      } else {
        vm.$router.push({ name: "accounts_payable" });
      }
    });
  },
  data() {
    return {
      sendDate: "",
      purchased_journals: [],
      temp: [],
      msg: "",
      empty: false,
      isAdmin: false,
      projects: [],
      selectedProject: "",
      selectedBuilding: "",
      buildings: [],
      isBuilding: false,
      okStartDate: "",
      okEndDate: "",
    };
  },
  created() {
    if (User.getGuard() == "admin") {
      this.isAdmin = true;
      this.isManager = false;
      axios
        .get("/api/fetchProjectsPayableJournal")
        .then((res) => {
          this.projects = res.data;
          console.log(res.data);
        })
        .catch((err) => {
          console.log(err.response);
        });
    } else {
      this.isAdmin = false;
      this.isManager = true;
      axios.get("/api/fethProjectPurchaseManager/" + User.getUserName()).then((res) => {
        this.projects = res.data;
        console.log(this.projects);
      });
    }
  },
  methods: {
    getUrlID($payment_id) {
      axios
        .get("/api/purchased_journal/getID/" + $payment_id)
        .then((res) => {
          let id = res.data.id;

          this.$router.push({ name: "payment_view_voucher", params: { id: id } });
        })
        .catch((err) => {});
    },
    showAll() {
      axios
        .get("/api/accounts_payable")
        .then((res) => {
          const purchase = res.data;
          this.empty = false;
          this.purchased_journals = [];
          purchase.forEach((item) => {
            this.purchased_journals.push(item);
          });
        })
        .catch((err) => {});
    },
    dateAccounts() {
      const data = {
        startDate: this.okStartDate,
        endDate: this.okEndDate,
      };
      axios
        .post("/api/accounts_payable/daily_journal", data, {
          headers: {
            "Content-Type": "application/json",
            Accept: "application/json",
          },
        })
        .then((res) => {
          this.purchased_journals = [];
          this.empty = false;
          res.data.forEach((item) => {
            if (item) {
              this.purchased_journals.push(item);
            }
          });
          if (res.data.Empty) {
            this.empty = true;
            this.msg = res.data.Empty;
          }
        })
        .catch((err) => {
          this.empty = true;
          this.msg = "There is no purchased journal in this date";
        });
    },
  },
  computed: {
    selectDate() {
      axios
        .get("/api/accounts_payable/daily_journal/" + this.sendDate)
        .then((res) => {
          this.purchased_journals = [];
          this.empty = false;
          res.data.forEach((item) => {
            if (item) {
              this.purchased_journals.push(item);
            }
          });
          if (res.data.Empty) {
            this.empty = true;
            this.msg = res.data.Empty;
          }
        })
        .catch((err) => {
          this.empty = true;
          this.msg = "There is no purchased journal in this date";
        });
    },
    chooseProject() {
      this.isBuilding = true;
      axios
        .get("/api/fetchPayableJournalProject/" + this.selectedProject)
        .then((res) => {
          this.purchased_journals = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });
      axios
        .get("/api/fetchBuildingInventory/" + this.selectedProject)
        .then((res) => {
          this.buildings = res.data;
          console.log(this.buildings);
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
    chooseBuilding() {
      axios
        .get("/api/getPayableByBuilding/" + this.selectedBuilding)
        .then((res) => {
          this.purchased_journals = res.data;
        })
        .catch((err) => {
          console.log(err.response);
        });
    },
  },
};
</script>
<style>
.formBox {
  border: 1px solid #4e3089;
  margin: 1rem;
  box-sizing: border-box;
  width: 100%;
}
.depositorBox {
  font-size: 0.85em;
}
.box_container {
  display: flex;
}
.title_col {
  width: 60%;
}
.plusBtn {
  width: 100%;
  display: flex;
}
.plusSection {
  width: 100%;
  display: flex;
}
.faBtn {
  text-align: right;
  margin-top: 3em;
  padding-right: 3%;
  margin-bottom: 1em;
}
.faBtnCross button {
  background: red;
  margin-top: 2em;
  color: white;
  border: none;
  border-radius: 10%;
}
.faBtn button {
  background: #5252d7;
  color: white;
  border: none;
  border-radius: 10%;
}
.cashSection {
  padding: 2rem 0;
}
.additionalPart {
  width: 100%;
  color: black;
  margin: 1rem 2rem;
}
.two_group {
  display: flex;
}

@media only screen and (max-width: 900px) {
  .title_col {
    width: 100%;
  }
}
</style>
