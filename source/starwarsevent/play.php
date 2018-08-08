<?php

use Symfony\Component\Debug\Debug;
use Symfony\Component\HttpFoundation\Request;

require __DIR__.'/app/autoload.php';
Debug::enable();

$kernel = new AppKernel('dev', true);
$kernel->loadClassCache();
$request = Request::createFromGlobals();

$kernel->boot();
$container = $kernel->getContainer();
$container->enterScope("request");
$container->set("request",$request);


$templating = $container->get("templating");

use Yoda\EventBundle\Entity\Event;
$event = new Event();
$event->setName("Boonkuae's surprise party!");
$event->setLocation("Jan-Pen Cafe");
$event->setTime(new \DateTime("tomorrow noon"));
$event->setDetails("Farewell party surprise!!!");

$em = $container->get('doctrine')->getManager();
$em->persist($event);
$em->flush();