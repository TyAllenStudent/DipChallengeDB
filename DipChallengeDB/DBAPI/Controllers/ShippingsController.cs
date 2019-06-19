using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Description;
using DBAPI.Models;

namespace DBAPI.Controllers
{
    public class ShippingsController : ApiController
    {
        private Week16_DBChallengeEntities db = new Week16_DBChallengeEntities();

        // GET: api/Shippings
        public IQueryable<Shipping> GetShippings()
        {
            return db.Shippings;
        }

        // GET: api/Shippings/5
        [ResponseType(typeof(Shipping))]
        public async Task<IHttpActionResult> GetShipping(string id)
        {
            Shipping shipping = await db.Shippings.FindAsync(id);
            if (shipping == null)
            {
                return NotFound();
            }

            return Ok(shipping);
        }

        // PUT: api/Shippings/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PutShipping(string id, Shipping shipping)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != shipping.ShipMode)
            {
                return BadRequest();
            }

            db.Entry(shipping).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ShippingExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/Shippings
        [ResponseType(typeof(Shipping))]
        public async Task<IHttpActionResult> PostShipping(Shipping shipping)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Shippings.Add(shipping);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (ShippingExists(shipping.ShipMode))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = shipping.ShipMode }, shipping);
        }

        // DELETE: api/Shippings/5
        [ResponseType(typeof(Shipping))]
        public async Task<IHttpActionResult> DeleteShipping(string id)
        {
            Shipping shipping = await db.Shippings.FindAsync(id);
            if (shipping == null)
            {
                return NotFound();
            }

            db.Shippings.Remove(shipping);
            await db.SaveChangesAsync();

            return Ok(shipping);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool ShippingExists(string id)
        {
            return db.Shippings.Count(e => e.ShipMode == id) > 0;
        }
    }
}