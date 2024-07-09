<?php

namespace App\Http\Controllers;

use App\Models\LateFine;
use App\Http\Requests\StoreLateFineRequest;
use App\Http\Requests\UpdateLateFineRequest;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Response;

class LateFineController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(): Response
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(): Response
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(StoreLateFineRequest $request): RedirectResponse
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(LateFine $lateFine): Response
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(LateFine $lateFine): Response
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateLateFineRequest $request, LateFine $lateFine): RedirectResponse
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(LateFine $lateFine): RedirectResponse
    {
        //
    }
}
