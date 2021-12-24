//lint:file-ignore ST1006 receiver name should be a reflection of its identity; don't use generic names such as "this" or "self"
package binance

import (
	"context"
	"fmt"

	exchange "github.com/adshao/go-binance/v2"
	"github.com/adshao/go-binance/v2/common"
)

type BookEntry = common.PriceLevel

func (self *Client) Depth(symbol string, limit int) (*exchange.DepthResponse, error) {
	defer AfterRequest()
	if limit < 500 {
		BeforeRequest(self, Method[DEPT], fmt.Sprintf(Path[DEPT], symbol), 1)
	} else if limit < 1000 {
		BeforeRequest(self, Method[DEPT], fmt.Sprintf(Path[DEPT], symbol), 5)
	} else if limit < 5000 {
		BeforeRequest(self, Method[DEPT], fmt.Sprintf(Path[DEPT], symbol), 10)
	} else {
		BeforeRequest(self, Method[DEPT], fmt.Sprintf(Path[DEPT], symbol), 50)
	}
	dept, err := self.inner.NewDepthService().Symbol(symbol).Limit(limit).Do(context.Background())
	self.handleError(err)
	return dept, err
}
