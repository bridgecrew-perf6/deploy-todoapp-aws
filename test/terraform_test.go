package terraformtest

import (
	"encoding/json"
	"fmt"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"io/ioutil"
	"testing"

	_ "github.com/gruntwork-io/terratest/modules/aws"
	_ "github.com/gruntwork-io/terratest/modules/random"
	_ "github.com/gruntwork-io/terratest/modules/terraform"
	_ "github.com/stretchr/testify/assert"
)

var config *terraform.Options

func init() {
	data, err := ioutil.ReadFile("./env.json")

	if err != nil {
		fmt.Print(err)
	}

	var vars map[string]interface{}

	err = json.Unmarshal(data, &vars)

	if err != nil {
		fmt.Println("error:", err)
	}

	config = &terraform.Options{
		TerraformDir: "../",
		Vars:         vars,
	}
}

func TestCreate(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, config)
	terraform.InitAndApply(t, terraformOptions)

}

func TestDestroy(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, config)

	terraform.Destroy(t, terraformOptions)
}
