package terraformtest

import (
	"testing"

	_ "github.com/gruntwork-io/terratest/modules/aws"
	_ "github.com/gruntwork-io/terratest/modules/random"
	_ "github.com/gruntwork-io/terratest/modules/terraform"
	_ "github.com/stretchr/testify/assert"
)

func TestTerraform(t *testing.T) {

}
