using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ExamenASP.Data;
using ExamenASP.Models;
using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Mvc;

namespace ExamenASP.Controllers
{
    [ApiController]
    [EnableCors("_myAllowSpecificOrigins")]
    public class PersonsController : ControllerBase
    {

        private readonly ChannelsContext _channelsContext;

        private readonly PersonsContext _context;

        public PersonsController(PersonsContext context, ChannelsContext channelsContext)
        {
            _context = context;
            _channelsContext = channelsContext;
        }

        [HttpGet("persons")]
        public List<Persons> GetAllPersons()
        {
            return _context.Persons.ToList();
        }

        [HttpGet("channels/{username}")]
        public List<Channels> GetAllChannels(String username)
        {
            try
            {
                var person = _context.Persons.ToList().First(e => e.Name == username);
                return _channelsContext.Channels.ToList()
                    .Where(e => e.OwnerId == person.Id)
                    .ToList();
            }
            catch (Exception)
            {
                return null;
            }
        }

        [HttpGet("auth/{username}")]
        public Persons Auth(string username)
        {
            try
            {
                var person = _context.Persons.ToList().First(e => e.Name == username);
                return person;
            }
            catch (Exception)
            {
                return null;
            }
        }

        [HttpGet("personal/{id}")]
        public List<Channels> GetPersonalChannels(int id)
        {
            try
            {
                var person = _context.Persons.ToList().First(e => e.Id == id).Name;
                return _channelsContext.Channels
                    .ToList()
                    .Where(e => e.Subscribers.Contains(person))
                    .ToList();
            }
            catch (Exception)
            {
                return null;
            }
        }

        [HttpGet("subscribe/{channel}/{username}")]
        public Channels Subscribe(string channel, string username)
        {
            try
            {
                var cha = _channelsContext.Channels
                    .ToList()
                    .First(e => e.Name == channel);
                if (cha.Subscribers.Contains(username))
                {
                    var subs = cha.Subscribers.Split(",");
                    subs.Select(e => e.Split(' '))
                        .ToList()
                        .ForEach(t =>
                        {
                            if (t[0] == username)
                            {
                                t[1] = DateTime.UtcNow.Date.ToString("yyyy-MM-dd");
                            }
                        });
                    var newSubs = "";
                    subs.ToList()
                        .ForEach(e => newSubs += e.ToString() + ", ");
                    newSubs = newSubs.Remove(newSubs.Length - 2);
                    cha.Subscribers = newSubs;
                    _channelsContext.Channels.Update(cha);
                    _channelsContext.SaveChanges();
                    return cha;
                }

                cha.Subscribers += ", " + username + " " + DateTime.UtcNow.Date.ToString("yyyy-MM-dd");
                _channelsContext.Channels.Update(cha);
                _channelsContext.SaveChanges();
                return cha;
                // var subs = cha.Subscribers.Split(",");

            }
            catch (Exception)
            {
                return null;
            }
        }
    }
}