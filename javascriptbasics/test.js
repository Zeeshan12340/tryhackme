#!/usr/bin/env nodejs
const randomPokemon = [
    		'Bulbasaur', 'Charmander', 'Squirtle',
    		'Snorlax',
    		'Zapdos',
    		'Mew',
    		'Charizard',
    		'Grimer',
    		'Metapod',
    		'Magikarp'
    	];
    	const original = randomPokemon.sort((pokemonName) => {
    		const [aLast] = pokemonName.split(', ');
    	});

    	console.log(original);
